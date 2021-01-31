# Home Insurance Modelling

This folder contains the notebook used for the modelling on home insurance data. The notebook has fuller details on the steps taken; here we will just outline the main steps undertaken. 

The feature data that was constructed included a label, with a value of 1 if the policy was lapsed, and 0 otherwise.
The aim was to use this label for a binary classification task, exploring 3 popular models for the task. 

The feature data was split into training, validation, and test datasets - roughly 70/20/10 split.
The split was based on quote date: ideally we want to be able to predict the status of future policies, therefore the validation and test data should contain data in a future timeframe that isn’t available to the training data.

Some final feature engineering had to be undertaken before we could use the data:
* randomly shuffle the training, validation and test sets
* one-hot encode the STRING field columns (P1_EMP_STATUS, P1_MAR_STATUS, P1_SEX, PAYMENT_METHOD)
* scale datasets according to the training set distribution, again to avoid feature leakage from the validation and test sets in the training data

We then proceeded to try three different models: logistic regression, random forest, and XGBoost. We also explored the use of unnormalised and normalised data, reducing the feature set, and hyperparameterisation, in attempts to improve performance. 
In the end, hyperparameterised XGBoost on all the features normalised performed the best in terms of performance metrics, but there is certainly scope for more improvements.