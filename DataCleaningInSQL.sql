/*
Cleaning Data in SQL
*/


-- Remove Time from SaleDate

SELECT SaleDateConverted, CONVERT(Date, SaleDate)
FROM [HousingDataNashville].[dbo].[NashvilleHousing]

ALTER TABLE [NashvilleHousing] 
ADD SaleDateConverted Date;

UPDATE [NashvilleHousing]
SET SaleDateConverted = CONVERT(Date, SaleDate);

-- Populate NULL Values in Property Address Data

SELECT *
FROM [HousingDataNashville].[dbo].[NashvilleHousing]
WHERE PropertyAddress IS NULL;

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM [HousingDataNashville].[dbo].[NashvilleHousing] a
JOIN [HousingDataNashville].[dbo].[NashvilleHousing] b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE b.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM [HousingDataNashville].[dbo].[NashvilleHousing] a
JOIN [HousingDataNashville].[dbo].[NashvilleHousing] b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

-- Separate Address into columns : Address, City, State

SELECT PropertyAddress
FROM [HousingDataNashville].[dbo].[NashvilleHousing]

SELECT 
	PARSENAME(REPLACE(PropertyAddress, ',','.'), 2) AS Street, 
	PARSENAME(REPLACE(PropertyAddress, ',','.'), 1) AS CityAddress
FROM [HousingDataNashville].[dbo].[NashvilleHousing]

ALTER TABLE [NashvilleHousing] 
ADD StreetAddress NVARCHAR(255);

ALTER TABLE [NashvilleHousing] 
ADD City NVARCHAR(255);

UPDATE [NashvilleHousing]
SET StreetAddress = PARSENAME(REPLACE(PropertyAddress, ',','.'), 2);

UPDATE [NashvilleHousing]
SET City = PARSENAME(REPLACE(PropertyAddress, ',','.'), 1);

SELECT
	PARSENAME(REPLACE(OwnerAddress, ',','.'), 3),
	PARSENAME(REPLACE(OwnerAddress, ',','.'), 2),
	PARSENAME(REPLACE(OwnerAddress, ',','.'), 1)
FROM [HousingDataNashville].[dbo].[NashvilleHousing];

ALTER TABLE [NashvilleHousing] 
ADD OwnerStreet NVARCHAR(255);

ALTER TABLE [NashvilleHousing] 
ADD OwnerCity NVARCHAR(255);

ALTER TABLE [NashvilleHousing] 
ADD OwnerState NVARCHAR(255);

UPDATE [NashvilleHousing]
SET OwnerStreet = PARSENAME(REPLACE(OwnerAddress, ',','.'), 3);

UPDATE [NashvilleHousing]
SET OwnerCity = PARSENAME(REPLACE(OwnerAddress, ',','.'), 2);

UPDATE [NashvilleHousing]
SET OwnerState = PARSENAME(REPLACE(OwnerAddress, ',','.'), 1);


-- Change Y and N in SoldAsVacant to Yes and No

SELECT SoldAsVacant FROM [HousingDataNashville].[dbo].[NashvilleHousing]
WHERE SoldAsVacant = 'N' OR SoldAsVacant = 'Y';

SELECT SoldAsVacant,
	CASE 
		WHEN SoldAsVacant = 'Y' THEN 'Yes'
		WHEN SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
	END
FROM [HousingDataNashville].[dbo].[NashvilleHousing];

UPDATE [NashvilleHousing]
SET SoldAsVacant = 
	CASE 
		WHEN SoldAsVacant = 'Y' THEN 'Yes'
		WHEN SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
	END;

-- Remove Unused Columns
SELECT * 
FROM [HousingDataNashville].[dbo].[NashvilleHousing];

ALTER TABLE [HousingDataNashville].[dbo].[NashvilleHousing]
DROP COLUMN PropertyAddress, SaleDate, OwnerAddress
