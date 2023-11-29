# Database setup

Locate the "scripts" folder

1. Navigate to its content.
2. Execute the file `1-scriptDDL.sql`.
3. Execute the file `2-SequenceAutoincrementable.sql`.
4. Execute the file `3-UUID.sql`.

## Locate the "triggers" folder

1. Access the content of the `Triggers` folder and execute the files in order respectly.
2. Access the content of the `DataValidations` folder and execute the files.

## Locate the "functions" folder

1. Enter the content of the `functions` folder.
2. Execute the files from 1-.. 12 respectively.
3. Insert data to test that the functions are working correctly.

*Please note that if you want to save some steps, you can:*

1. Locate the folder *backupDB*.
2. Go to pgAdmin4.
3. Create a database.
4. Right-click and select Restore...
5. Choose the file **ferresysDB.sql** located in the backupDB folder.
6. Done, you now have the database with the tables created.