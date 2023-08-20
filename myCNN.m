fmriDatasetPath = ['AllData' filesep '10'];
fmris = imageDatastore(fmriDatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames',"FileExtensions",".mat","ReadFcn",@(x) matRead(x));
labelCount = countEachLabel(fmris);
numTrainFiles = int32(min(table2array(labelCount(:,2)))*4/5);
[fmriTrain,fmriValidation] = splitEachLabel(fmris,numTrainFiles,'randomize');
outputSize = [52 52 38];
%%rescale_fmriTrain = transform(fmriTrain, @(x) rescale(x,0,1));
aug_fmriTrain = augment3d(fmriTrain, outputSize, 'Interpolation', 'linear');%, "ColorPreprocessing","rgb2gray");
aug_fmriValidation = augment3d(fmriValidation, outputSize, 'Interpolation', 'linear')%;, "ColorPreprocessing","rgb2gray");

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
'ValidationData',aug_fmriValidation, ...
'ValidationFrequency',10, ...
'Verbose',false, ...
'Plots','training-progress');
analyzeNetwork(layers);
net = trainNetwork(aug_fmriTrain,layers,options);
YPred = classify(net,aug_fmriValidation);
YValidation = aug_fmriValidation.Labels;
accuracy = sum(YPred == YValidation)/numel(YValidation)
function data = matRead(filename)
    inp = load(filename);
    f = fields(inp);
    data = inp.(f{1});
end
