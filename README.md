# Spam Classifier

A spam classifier, built using a support vector machine (SVM), which classifies a given input email as SPAM or NOT-SPAM. The training set (spamTrain.mat) contains 4000 training examples of spam and non-spam email; the test set (spamTest.mat) contains 1000 test examples. The classifier achieves a training accuracy of about 99.9% and a test accuracy of about 97.5%. 

I will adapt my spam classifier from the second part of the sixth exercise from Andrew Ng’s Machine Learning Course on Coursera. However, we will train our SVM classifier using the functionality available in the MATLAB Statistics and Machine Learning toolbox (while his course trained the SVM using course-provided code). The dataset included here is based on a subset of the SpamAssassin Public Corpus. We will only be using the body of the email in our spam classification example.

# Running the Project 

- Make sure you have MATLAB or Octave installed. 
- Clone the project to your local machine. 
- Run spamclassifier.m. For a guided implementation, you can instead run the live script SpamClassifierSVM.mlx. 

# Project Details

I will train a classifier to classify whether a given email is spam (which we will call y = 1) or not spam (which we will call y = 0). 

In the first step of the spam classifier, I will preprocess all emails. Emails contain many features: URLs, numbres, email addresses, dollar amounts, etc. First, I will treat all the features of a certain type the same; that is, all URLs will be treated the same, all numbers will be treated the same, etc. Thus, our spam classifier will make a classification based on whether any URL was in the email, rather than depending on whether a specific URL was in the email. This typically improves the performance of a spam classifier, since spammers often randomize the URLs, and thus the odds of seeing any particular URL again in a new piece of spam is very small. 

We will implement the following preprocessing steps: 
* Convert the entire email to lower case.
* Strip all HTML tags from the emails.
* Replace all URLs with "httpaddr".
* Replace all email addresses with "emailaddr".
* Replace all numbers with the text "number".
* Replace all dollar signs ($) with the text "dollar".
* Reduce words to their stemmed form; that is, words such as "include", "includes", "included", and "including" are all replaced with "includ".
* Remove all non-words; that is, non-words and punctuation have been removed. White spaces are trimmed to a single space character.

After preprocessing all emails, we will have a list of words for each email. The next step is to choose the words we will use in our classifier (vs the words we will leave out). To keep things simple, we will choose only the most frequently occuring words as the set of words considering (the vocabulary list). If we were to include words that occur rarely in the training set, we overfit our training set. The complete vocabulary list is in the file vocab.txt. The vocabulary list was selected by choosing all words which occur at least a 100 times in the spam corpus, resulting in a list of 1899 words. In practice, a vocabulary list with about 10,000 to 50,000 words is often used; to improve this project in the future, I can increase the size of my training set, which will generate a larger vocabulary list. 

With our vocabulary list, we can now map each word in the preprocessing emails into a list of word indices that contains the index of the word in the vocabulary list. The code in processEmail.m performs this mapping. In the code, a given string str (a single word from the processed email) is searched in the vocabulary list vocabList. If the word exists, the index of the word is added into the word_indices variable. If the word does not exist, and is therefore not in the vocabulary, the word can be skipped.

The feature extraction converts each email into a vector in . Specically, the feature for an email corresponds to whether the nth word in the dictionary occurs in the email. The code in emailFeatures.m generates a feature vector for an email, given the word indices. For example, after running the code on a email sample (emailSample1.txt), the feature vector has length 1899 and 45 non-zero entries.

Next, a preprocessed training dataset will be loaded and it will be used to train a SVM classifier. spamTrain.mat contains 4000 training examples of spam and non-spam email, while spamTest.mat contains 1000 test examples. Each original email was processed using the processEmail.m and emailFeatures.m functions and converted into a vector. After loading the dataset, the code will proceed to train a SVM to classify between spam (y=1) and non-spam (y=0) emails. I will use the functionality available in the MATLAB Statistics and Machine Learning toolbox to train our SVM using a linear kernel.

After training, our classifier gets a training accuracy of approximately 99.95% and a test accuracy of approximately 97.5%.

We can now use our trained model to classify emails! Four sample emails are provided (two spam emails and two non-spam emails). However, if you want to classify your own emails, simply add your own email text file to the folder, add the file name to the code below, and select "yourEmail" from the dropdown menu!

