fmriDatasetPath = ['AllData' filesep '10'];
fmris = image3dDatastore(fmriDatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames',"FileExtensions",".mat","ReadFcn",@(x) matRead(x));
labelCount = countEachLabel(fmris);
numTrainFiles = int32(min(table2array(labelCount(:,2)))*4/5);
[fmriTrain,fmriValidation] = splitEachLabel(fmris,numTrainFiles,'randomize');

layers = [
image3dInputLayer([53 63 38])
convolution3dLayer([3 3 3],32)
reluLayer
maxPooling3dLayer(2,'Stride',2)
convolution3dLayer([3 3 3],16)
reluLayer
maxPooling3dLayer(2,'Stride',2)
convolution3dLayer([3 3 3],8,'Padding','same')
reluLayer
fullyConnectedLayer(2)
softmaxLayer
classificationLayer]
options = trainingOptions('sgdm', ...
'InitialLearnRate',0.01, ...
'MaxEpochs',4, ...
'Shuffle','every-epoch', ...
'ValidationData',fmriValidation, ...
'ValidationFrequency',10, ...
'Verbose',false, ...
'Plots','training-progress');
analyzeNetwork(layers);
net = trainNetwork(fmriTrain,layers,options);
YPred = classify(net,fmriValidation);
YValidation = fmriValidation.Labels;
accuracy = sum(YPred == YValidation)/numel(YValidation)
function data = matRead(filename)
    inp = load(filename);
    f = fields(inp);
    data = inp.(f{1});
end
