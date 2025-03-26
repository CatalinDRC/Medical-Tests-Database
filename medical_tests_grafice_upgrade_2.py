import pandas as pd
import matplotlib.pyplot as plt
from sqlalchemy import create_engine

# Connect to the MySQL database using SQLAlchemy
engine = create_engine('mysql+mysqlconnector://root:Ronaldo123$@localhost/draica_schema')

# Retrieve data from the Tests_Taken table
query = '''
    SELECT Tests.test_text, COUNT(Tests_Taken.test_id) as num_taken
    FROM Tests_Taken
    INNER JOIN Tests ON Tests_Taken.test_id = Tests.test_id
    GROUP BY Tests.test_text
'''
df_tests_taken = pd.read_sql_query(query, engine)

# Retrieve data from the Medical_Register table
query = '''
    SELECT gender, COUNT(*) as num_registered
    FROM Medical_Register
    GROUP BY gender
'''
df_gender_distribution = pd.read_sql_query(query, engine)

# Retrieve data from the Tests_Taken table for line chart
query = '''
    SELECT DATE_FORMAT(date_taken, '%Y-%m') AS month, COUNT(test_taken_id) as num_tests
    FROM Tests_Taken
    GROUP BY month
    ORDER BY month
'''
df_tests_monthly = pd.read_sql_query(query, engine)

# Retrieve data from the Tests_Taken table by test station
query = '''
    SELECT Test_Stations.physical_address, COUNT(Tests_Taken.test_taken_id) as num_tests_taken
    FROM Test_Stations
    INNER JOIN Tests_Taken ON Test_Stations.test_station_id = Tests_Taken.test_station_id
    GROUP BY Test_Stations.physical_address
'''
df_tests_by_station = pd.read_sql_query(query, engine)

# Retrieve data from the Tests_Taken table by examiner
query = '''
    SELECT CONCAT(Examiners.fist_name, ' ', Examiners.last_name) as examiner_name, COUNT(Tests_Taken.test_taken_id) as num_tests_taken
    FROM Examiners
    INNER JOIN Tests_Taken ON Examiners.examiner_id = Tests_Taken.examiner_id
    GROUP BY examiner_name
'''
df_tests_by_examiner = pd.read_sql_query(query, engine)

# Retrieve data from the Tests_Taken table by examiner
query = '''
    SELECT CONCAT(Examiners.fist_name, ' ', Examiners.last_name) as examiner_name,
    COUNT(Tests_Taken.test_taken_id) as num_tests_taken
    FROM Examiners
    INNER JOIN Tests_Taken ON Examiners.examiner_id = Tests_Taken.examiner_id
    GROUP BY examiner_name
'''
df_tests_by_examiner = pd.read_sql_query(query, engine)

query = '''
    SELECT CASE
        WHEN YEAR(CURRENT_DATE()) - YEAR(date_of_birth) < 18 THEN 'Under 18'
        WHEN YEAR(CURRENT_DATE()) - YEAR(date_of_birth) >= 18 AND YEAR(CURRENT_DATE()) - YEAR(date_of_birth) < 30 THEN '18-29'
        WHEN YEAR(CURRENT_DATE()) - YEAR(date_of_birth) >= 30 AND YEAR(CURRENT_DATE()) - YEAR(date_of_birth) < 50 THEN '30-49'
        WHEN YEAR(CURRENT_DATE()) - YEAR(date_of_birth) >= 50 THEN '50+'
        ELSE 'Unknown'
    END AS age_group,
    COUNT(*) as num_registered
    FROM Medical_Register
    GROUP BY age_group
    ORDER BY FIELD(age_group, 'Under 18', '18-29', '30-49', '50+')
'''

df_age_distribution = pd.read_sql_query(query, engine)



# Close the database connection
engine.dispose()

# Generate the charts
fig, axes = plt.subplots(nrows=2, ncols=3, figsize=(16, 12))

# Bar chart - Tests Taken
axes[0, 0].bar(df_tests_taken['test_text'], df_tests_taken['num_taken'])
axes[0, 0].set_xlabel('Test')
axes[0, 0].set_ylabel('Number of Tests Taken')
axes[0, 0].set_title('Tests Taken ')
axes[0, 0].tick_params(axis='x', rotation=45)

# Pie chart - Gender Distribution
axes[0, 1].pie(df_gender_distribution['num_registered'], labels=df_gender_distribution['gender'], autopct='%1.1f%%')
axes[0, 1].set_title('Medical Register Gender Distribution ')

# Line chart - Tests Taken Over Time
axes[0, 2].plot(df_tests_monthly['month'], df_tests_monthly['num_tests'], marker='o')
axes[0, 2].set_xlabel('Month')
axes[0, 2].set_ylabel('Number of Tests Taken')
axes[0, 2].set_title('Tests Taken Over Time ')
axes[0, 2].tick_params(axis='x', rotation=45)

# Bar chart - Tests Taken by Test Station
axes[1, 0].barh(df_tests_by_station['physical_address'], df_tests_by_station['num_tests_taken'])
axes[1, 0].set_xlabel('Number of Tests Taken')
axes[1, 0].set_ylabel('Test Station')
axes[1, 0].set_title('Tests Taken by Test Station')

# Bar chart - Tests Taken by Examiner
axes[1, 1].barh(df_tests_by_examiner['examiner_name'], df_tests_by_examiner['num_tests_taken'])
axes[1, 1].set_xlabel('Number of Tests Taken')
axes[1, 1].set_ylabel('Examiner')
axes[1, 1].set_title('Tests Taken by Examiner')

# Bar chart - Age Distribution
axes[1, 2].bar(df_age_distribution['age_group'], df_age_distribution['num_registered'])
axes[1, 2].set_xlabel('Age Group')
axes[1, 2].set_ylabel('Number of Registrations')
axes[1, 2].set_title('Age Distribution')
axes[1, 2].tick_params(axis='x', rotation=45)

# Adjust spacing between subplots
plt.tight_layout()

# Show the combined chart
plt.show()

