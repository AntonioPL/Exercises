print "IMPORTING LIBRARIES..."
import pandas as pd
import numpy as np
import statsmodels.api as sm
import requests
from sklearn.ensemble import RandomForestRegressor

import cPickle

#DOWLOADING FILE FROM DROPBOX FIRST TIME
import os.path
import time
import random
while not os.path.exists('EX2_DATA_BASE.xlsx'):
    time.sleep (3*random.random()); #Sleeping less than 3 seconds before going to Dropbox - avoid too many students at once.
    if not os.path.exists('EX2_DATA_BASE.xlsx'):
        print "DOWLOADING FILE EX2_DATA_BASE.xlsx FROM DROPBOX BECAUSE LOCAL FILE DOES NOT EXIST!"
#        csvfile = urllib2.urlopen("https://dl.dropboxusercontent.com/u/28535341/EX2_DEV_DATA.xlsx")
        resp = requests.get("https://dl.dropboxusercontent.com/u/28535341/EX2_DATA_BASE.xlsx")        
        output = open('EX2_DATA_BASE.xlsx','wb')
        output.write(resp.content)
        output.close()
#DOWLOADING FILE FROM DROPBOX FIRST TIME

    
print "LOADING DATASETS..."
#df = pd.read_csv("EX2_DEV_DATA.xlsx",sep=";") #DEV-SAMPLE
df = pd.read_excel(open('EX2_DATA_BASE.xlsx','rb'), sheetname='DATA')
df_dictionary = pd.read_excel(open('EX2_DATA_BASE.xlsx','rb'), sheetname='DICTIONARY')



print "GETTING LIST OF VARIABLES..."

print "-> targe variable:"
target_variable = str(df_dictionary[df_dictionary['TYPE_OF_VARIABLE'] == 'TARGET']['FIELD_NAME'].tolist()[0])
print "target_variable = ",target_variable


list_of_inputs_for_model0 = df_dictionary[df_dictionary['TYPE_OF_VARIABLE'] == 'INPUT0']['FIELD_NAME'].tolist()
print "list_of_inputs_for_model0 = ",list_of_inputs_for_model0


list_of_inputs_for_model1 = df_dictionary[(df_dictionary['TYPE_OF_VARIABLE'] == 'INPUT0') | (df_dictionary['TYPE_OF_VARIABLE'] == 'INPUT1')]['FIELD_NAME'].tolist()
print "list_of_inputs_for_model1 = ",list_of_inputs_for_model1

list_of_inputs_for_model2 = df_dictionary[(df_dictionary['TYPE_OF_VARIABLE'] == 'INPUT0') | (df_dictionary['TYPE_OF_VARIABLE'] == 'INPUT1')| (df_dictionary['TYPE_OF_VARIABLE'] == 'INPUT2')]['FIELD_NAME'].tolist()
print "list_of_inputs_for_model2 = ",list_of_inputs_for_model2

list_of_inputs_for_model3 = df_dictionary[(df_dictionary['TYPE_OF_VARIABLE'] == 'INPUT0') | (df_dictionary['TYPE_OF_VARIABLE'] == 'INPUT1')| (df_dictionary['TYPE_OF_VARIABLE'] == 'INPUT2')| (df_dictionary['TYPE_OF_VARIABLE'] == 'INPUT3')]['FIELD_NAME'].tolist()
print "list_of_inputs_for_model3 = ",list_of_inputs_for_model3

list_of_inputs_for_model4 = df_dictionary[(df_dictionary['TYPE_OF_VARIABLE'] == 'INPUT0') | (df_dictionary['TYPE_OF_VARIABLE'] == 'INPUT1')| (df_dictionary['TYPE_OF_VARIABLE'] == 'INPUT2')| (df_dictionary['TYPE_OF_VARIABLE'] == 'INPUT3')| (df_dictionary['TYPE_OF_VARIABLE'] == 'INPUT4')]['FIELD_NAME'].tolist()
print "list_of_inputs_for_model4 = ",list_of_inputs_for_model4

df = df.fillna(0)

#### PREDICTING -  target_variable #######

print "STEP 1: DOING MY TRANSFORMATIONS..."
print "model 0"
list_of_inputs_for_model0.remove('TICKER')
list_of_inputs_for_model0.remove('NAME')
list_of_inputs_for_model0.remove('INDUSTRY_GROUP')
print "model 1"
list_of_inputs_for_model1.remove('TICKER')
list_of_inputs_for_model1.remove('NAME')
list_of_inputs_for_model1.remove('INDUSTRY_GROUP')
print "model 2"
list_of_inputs_for_model2.remove('TICKER')
list_of_inputs_for_model2.remove('NAME')
list_of_inputs_for_model2.remove('INDUSTRY_GROUP')
print "model 3"
list_of_inputs_for_model3.remove('TICKER')
list_of_inputs_for_model3.remove('NAME')
list_of_inputs_for_model3.remove('INDUSTRY_GROUP')
print "model 4"
list_of_inputs_for_model4.remove('TICKER')
list_of_inputs_for_model4.remove('NAME')
list_of_inputs_for_model4.remove('INDUSTRY_GROUP')

print "STEP 2: SELECTING CHARACTERISTICS TO ENTER INTO THE MODEL..."
# in_model = list_inputs #['ib_var_1','icn_var_22','ico_var_25','if_var_65']
#in_model = ['BB_1YR_DEFAULT_PROB_CQ4_2013', 'BB_1YR_DEFAULT_PROB_CQ1_2014', 'BB_1YR_DEFAULT_PROB_CQ2_2014',
#            'BB_1YR_DEFAULT_PROB_CQ3_2014', 'BB_1YR_DEFAULT_PROB_CQ4_2014', 'BB_1YR_DEFAULT_PROB_CQ1_2015',
#           'BB_1YR_DEFAULT_PROB_CQ2_2015', 'BB_1YR_DEFAULT_PROB_CQ3_2015']

in_model0=list_of_inputs_for_model0
in_model1=list_of_inputs_for_model1
in_model2=list_of_inputs_for_model2
in_model3=list_of_inputs_for_model3
in_model4=list_of_inputs_for_model4

print "STEP 3: DEVELOPING THE MODEL..."
print "model 0"

#MODEL0#
X = df[in_model0]
y = df[target_variable]
#y = np.asarray(y, dtype="|S6")


try:
    rf = RandomForestRegressor()
    rf.fit(X, y)
    result = rf.fit(X,y)
    y_pred = result.predict(X)
except np.linalg.linalg.LinAlgError as err:
    if 'Singular matrix' in err.message:
        print "MODEL-INVALID (Singular Matrix)"
    else:
        raise

print "STEP 4: ASSESSING THE MODEL..."

# CALCULATING GINI PERFORMANCE ON DEVELOPMENT SAMPLE
from scipy.stats import spearmanr

spearman_correlation = spearmanr(y, y_pred)
print "Spearman Rank Correlation = ", spearman_correlation

print "STEP 4: EXPORT THE MODEL..."
print "model 0"
with open("RF0.pkl", "wb") as f:
    cPickle.dump(rf, f)

#MODEL1#

X = df[in_model1]
y = df[target_variable]
#y = np.asarray(y, dtype="|S6")


try:
    rf = RandomForestRegressor()
    rf.fit(X, y)
    result = rf.fit(X,y)
    y_pred = result.predict(X)
except np.linalg.linalg.LinAlgError as err:
    if 'Singular matrix' in err.message:
        print "MODEL-INVALID (Singular Matrix)"
    else:
        raise

print "STEP 4: ASSESSING THE MODEL..."

# CALCULATING GINI PERFORMANCE ON DEVELOPMENT SAMPLE
from scipy.stats import spearmanr

spearman_correlation = spearmanr(y, y_pred)
print "Spearman Rank Correlation = ", spearman_correlation

print "STEP 4: EXPORT THE MODEL..."
print "model 1"
with open("RF1.pkl", "wb") as f:
    cPickle.dump(rf, f)

#MODEL2#

X = df[in_model2]
y = df[target_variable]
#y = np.asarray(y, dtype="|S6")


try:
    rf = RandomForestRegressor()
    rf.fit(X, y)
    result = rf.fit(X,y)
    y_pred = result.predict(X)
except np.linalg.linalg.LinAlgError as err:
    if 'Singular matrix' in err.message:
        print "MODEL-INVALID (Singular Matrix)"
    else:
        raise

print "STEP 4: ASSESSING THE MODEL..."

# CALCULATING GINI PERFORMANCE ON DEVELOPMENT SAMPLE
from scipy.stats import spearmanr

spearman_correlation = spearmanr(y, y_pred)
print "Spearman Rank Correlation = ", spearman_correlation

print "STEP 4: EXPORT THE MODEL..."
print "model 2"
with open("RF2.pkl", "wb") as f:
    cPickle.dump(rf, f)

#MODEL3#

X = df[in_model3]
y = df[target_variable]
#y = np.asarray(y, dtype="|S6")


try:
    rf = RandomForestRegressor()
    rf.fit(X, y)
    result = rf.fit(X,y)
    y_pred = result.predict(X)
except np.linalg.linalg.LinAlgError as err:
    if 'Singular matrix' in err.message:
        print "MODEL-INVALID (Singular Matrix)"
    else:
        raise

print "STEP 4: ASSESSING THE MODEL..."

# CALCULATING GINI PERFORMANCE ON DEVELOPMENT SAMPLE
from scipy.stats import spearmanr

spearman_correlation = spearmanr(y, y_pred)
print "Spearman Rank Correlation = ", spearman_correlation

print "STEP 4: EXPORT THE MODEL..."
print "model 3"
with open("RF3.pkl", "wb") as f:
    cPickle.dump(rf, f)

#MODEL4#

X = df[in_model4]
y = df[target_variable]
#y = np.asarray(y, dtype="|S6")


try:
    rf = RandomForestRegressor()
    rf.fit(X, y)
    result = rf.fit(X,y)
    y_pred = result.predict(X)
except np.linalg.linalg.LinAlgError as err:
    if 'Singular matrix' in err.message:
        print "MODEL-INVALID (Singular Matrix)"
    else:
        raise

print "STEP 4: ASSESSING THE MODEL..."

# CALCULATING GINI PERFORMANCE ON DEVELOPMENT SAMPLE
from scipy.stats import spearmanr

spearman_correlation = spearmanr(y, y_pred)
print "Spearman Rank Correlation = ", spearman_correlation

print "STEP 4: EXPORT THE MODEL..."
print "model 4"
with open("RF4.pkl", "wb") as f:
    cPickle.dump(rf, f)


