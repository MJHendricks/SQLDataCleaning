# Data Cleaning in SQL

## Overview

This project focuses on cleaning and preparing a dataset using SQL queries. The dataset contains property data for residentual buildings in Nashville, Tennessee, including the owner, address, value of the property and other related information. The goal of this project is to ensure data accuracy, consistency, and reliability for downstream analysis and reporting purposes.

## Datasets

The final query, resulting in a clean and well formatted dataset has been exported into a seperate file for easy use.

### Messy Dataset
- Name: Nashville Housing Data
- Format: Excel (.xlsx)

### Clean Dataset
- Name: Nashville Housing Data Cleaned
- Format: CSV (.csv)

## Changes
The following changes were made to the original dataset:
- Removed the Time from the SaleDate column.
- Populated NULL values in PropertyAddress column with data from previous owners of the property.
- Seperated the Address into seperate columns: StreetAddress, City.
- Seperated the OwnerAddress into seperate columns: OwnerStreet, OwnerCity, OwnerState.
- Normalized the SoldAsVacant column to display values only as "Yes" or "No".
- Removed PropertyAddress and OwnerAddress columns.
