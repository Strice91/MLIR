% Load Data
load('A.txt')
load('A_Test_Binned.txt')
load('A_Train_Binned.txt')
load('B.txt')
load('pi.txt')

% Train Data p(O|Lambda)
[pTrain, aTrain] = hmmForward(B,A,A_Train_Binned,pi); 

logLH_Train = log(pTrain);

% Test Data p(O|Lambda)
[pTest, aTest] = hmmForward(B,A,A_Test_Binned,pi);

logLH_Test = log(pTest);

labels = logLH_Test > -120;


