import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.preprocessing import StandardScaler
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
import pickle
import sklearn
print(sklearn.__version__)
# Load the csv file
df = pd.read_csv(r"C:\Users\pabba\OneDrive\Documents\Python Data Analysis\ML-MODEL-DEPLOYMENT-USING-FLASK-main\ML-MODEL-DEPLOYMENT-USING-FLASK-main\Dataset.csv")

print(df.head())




# Function to apply transformations and plot the distributions
def transform_and_plot(df, transformations):
    fig, axes = plt.subplots(nrows=4, ncols=3, figsize=(15, 20))
    fig.suptitle('Transformed Distribution of Variables')

    for i, col in enumerate(df.columns):
        if col in transformations:
            transformed_data = transformations[col](df[col].replace(0, np.nan).dropna())  # Replace 0 with NaN for log and sqrt
            sns.histplot(transformed_data, ax=axes[i//3, i%3], kde=True,color='green')
            axes[i//3, i%3].set_title(f'Transformed {col}')
        else:
            sns.histplot(df[col], ax=axes[i//3, i%3], kde=True,color='green')
            axes[i//3, i%3].set_title(f'Original {col}')

    plt.tight_layout()
    plt.subplots_adjust(top=0.95)
    plt.show()

# Define the transformations for each variable
transformations = {
    'AccountWeeks': np.log1p,
    'DataUsage': np.sqrt,
    'CustServCalls': np.log1p,
    'DayMins': np.sqrt,
    'DayCalls': np.sqrt,
    'MonthlyCharge': np.log1p,
    'OverageFee': np.log1p,
    'RoamMins': np.sqrt
}

# Apply the transformations and plot the results
transform_and_plot(df, transformations)


# ## The transformed distributions of the variables are plotted. Here's a summary of the transformations applied:
# 
# ### Log transformation (np.log1p): Applied to AccountWeeks, CustServCalls, MonthlyCharge, and OverageFee.
# 
# ### Square root transformation (np.sqrt): Applied to DataUsage, DayMins, DayCalls, and RoamMins.
# 
# These transformations were chosen to reduce skewness and make the distributions more symmetrical. Some variables still exhibit skewness, indicating that further fine-tuning of transformations may be necessary.
# 
# ## <span style="color:darkviolet;">Further fine-tuning transformations of variables which are still displaying skewness</span>

# In[4]:


# Identify skewness in the transformed variables
skewness = df[transformations.keys()].apply(lambda x: transformations[x.name](x.replace(0, np.nan).dropna()).skew())
skewed_vars = skewness[abs(skewness) > 0.5].index.tolist()

# Define fine-tuned transformations
fine_tuned_transformations = {
    'AccountWeeks': np.sqrt,
    'CustServCalls': np.cbrt,
    'MonthlyCharge': np.cbrt,
    'OverageFee': np.cbrt,
    'DataUsage': np.log1p,
    'DayMins': np.log1p,
    'DayCalls': np.log1p,
    'RoamMins': np.log1p
}

# Apply fine-tuned transformations and plot the results
transform_and_plot(df, fine_tuned_transformations)


# ### Applying these fine tuned transformations

# In[5]:


# Apply fine-tuned transformations
for col, func in fine_tuned_transformations.items():
    df[col] = df[col].replace(0, np.nan).apply(func).fillna(0)
    
# Standardize the features

# Standardize the features
scaler = StandardScaler()
data_scaled = pd.DataFrame(scaler.fit_transform(df.drop(['Churn'], axis=1)), columns=df.columns.drop(['Churn']))

# Add the target
data_scaled['Churn'] = df['Churn']

# Handle NaN values in the scaled data
data_scaled = data_scaled.fillna(0)

# Print the updated dataset
data_scaled.head()
# Select independent and dependent variable
X = data_scaled.drop('Churn',axis=1)
y = data_scaled["Churn"]

from imblearn.over_sampling import SMOTE
# Apply SMOTE
smote = SMOTE(random_state=42)
X_resampled, y_resampled = smote.fit_resample(X, y)


# Split the dataset into train and test
X_train, X_test, y_train, y_test = train_test_split(X_resampled, y_resampled, test_size=0.3, random_state=50)
X_resampled.describe()
# Feature scaling
sc = StandardScaler()
X_train = sc.fit_transform(X_train)
X_test= sc.transform(X_test)

# Instantiate the model
classifier = RandomForestClassifier()

# Fit the model
classifier.fit(X_train, y_train)
y_pred=classifier.predict(X_test)
from sklearn.metrics import f1_score
f1_score(y_test,y_pred)

# Make pickle file of our model
pickle.dump(classifier, open("model.pkl", "wb"))

# Save the model
with open("model.pkl", "wb") as file:
    pickle.dump(classifier, file)

import os
os.getcwd()
