fmriDatasetPath = ['AllData' filesep '10'];
controlData=fileDatastore(fullfile(fmriDatasetPath ,'Control'),'ReadFcn',@load,'FileExtensions','.mat');
patientData=fileDatastore(fullfile(fmriDatasetPath ,'Patient'),'ReadFcn',@load,'FileExtensions','.mat');
cData = transform(controlData,@(data) rearrange_datastore(data));
pData = transform(patientData,@(data) rearrange_datastore(data));
trainData=combine(cData,pData);
fmris = fileDatastore(fmriDatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames');
labelCount = countEachLabel(fmris);
numTrainFiles = 750;
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');
layers = [
imageInputLayer([28 28 1])
convolution2dLayer(3,8,'Padding','same')
batchNormalizationLayer
reluLayer
maxPooling2dLayer(2,'Stride',2)
convolution2dLayer(3,16,'Padding','same')
batchNormalizationLayer
reluLayer
maxPooling2dLayer(2,'Stride',2)
convolution2dLayer(3,32,'Padding','same')
batchNormalizationLayer
reluLayer
fullyConnectedLayer(10)
softmaxLayer
classificationLayer]
options = trainingOptions('sgdm', ...
'InitialLearnRate',0.01, ...
'MaxEpochs',4, ...
'Shuffle','every-epoch', ...
'ValidationData',imdsValidation, ...
'ValidationFrequency',30, ...
'Verbose',false, ...
'Plots','training-progress');
net = trainNetwork(imdsTrain,layers,options);
YPred = classify(net,imdsValidation);
YValidation = imdsValidation.Labels;
accuracy = sum(YPred == YValidation)/numel(YValidation)
