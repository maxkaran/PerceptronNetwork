train = readtable('train.txt');

%Perceptrons that will say if it is a specific type of flower, since outputs are binary
setosa = perceptron;
versicolor = perceptron;
virginia = perceptron;

learning_constant = 0.01;

trained = 0; %flag that will be set to one once perceptron is trained
count = 1; %this will be used to traverse through the table and train with the proper data
iterations=0;
while trained == 0
    %read data from training data into corresponding attributes
    sepal_length = train{count, 1};
    sepal_width = train{count, 2};
    petal_length = train{count, 3};
    petal_width = train{count, 4};
    type_string = train{count, 5}{1};
    inputs = [sepal_length, sepal_width, petal_length, petal_width];
    if strcmp(type_string, 'Iris-setosa')
        type = 1;
    elseif strcmp(type_string, 'Iris-versicolor')
        type = 2;
    elseif strcmp(type_string, 'Iris-virginica')
        type = 3;
    else
        type = 0;
    end
    
    completed_training = 1; %%THIS IS A FLAG VARIABLE FOR WHEN THE PERCEPTRON CORRECTLY IDENTIFIES ALL TRAINING DATA
    
    setosa_result = fired(setosa, sepal_length, sepal_width, petal_length, petal_width);
    versicolor_result = fired(versicolor, sepal_length, sepal_width, petal_length, petal_width);
    virginia_result = fired(virginia, sepal_length, sepal_width, petal_length, petal_width);
    
    if type == 1 %if the training data passed in was a setosa
        if setosa_result ~= 1 %and the perceptron did not fire, the weights need to be increased
            setosa.weights(:) = setosa.weights(:) + learning_constant*inputs(:);
            completed_training = 0;
            %IF ANY OF THESE IF STATEMENTS ARE MET, THE ANN HAS FAILED AND
            %NEEDS TO CONTINUE TRAINING
        end
        if virginia_result == 1 %the perceptron fired when it should not have, the weight needs to be decreased
            virginia.weights(:) = virginia.weights(:) - learning_constant*inputs(:);
            completed_training = 0;
        end
        if versicolor_result == 1 %the perceptron fired when it should not have, the weight needs to be decreased
            versicolor.weights(:) = versicolor.weights(:) - learning_constant*inputs(:);
            completed_training = 0;
        end
    elseif type == 2
        if setosa_result == 1 %the perceptron fired when it should not have, the weight needs to be decreased
            setosa.weights(:) = setosa.weights(:) - learning_constant*inputs(:);
            completed_training = 0;
        end
        if virginia_result ~= 1 %the perceptron did not fire when it SHOULD HAVE, increase the weight
            virginia.weights(:) = virginia.weights(:) + learning_constant*inputs(:);
            completed_training = 0;
        end
        if versicolor_result == 1 %the perceptron fired when it should not have, the weight needs to be decreased
            versicolor.weights(:) = versicolor.weights(:) - learning_constant*inputs(:);
            completed_training = 0;
        end
    elseif type == 3
        if setosa_result == 1 %the perceptron fired when it should not have, the weight needs to be decreased
            setosa.weights(:) = setosa.weights(:) - learning_constant*inputs(:);
            completed_training = 0;
        end
        if virginia_result == 1 %the perceptron fired when it should not have, the weight needs to be decreased
            virginia.weights(:) = virginia.weights(:) - learning_constant*inputs(:);
            completed_training = 0;
        end
        if versicolor_result ~= 1 %the perceptron did NOT fire when it should not have, increase weight
            versicolor.weights(:) = versicolor.weights(:) + learning_constant*inputs(:);
            completed_training = 0;
        end    
    end
    count = count + 1;
    if count == 121 && completed_training == 1 %end training if the network correctly classifies every bit of data
        trained = 1;
    elseif count == 121
        count = 1;
    end
    iterations=iterations+1;
    if iterations > 10000 %end training after set number of loops
        trained = 1;
    end
    
end

%% TEST THE NETWORK
%track the # of correct vs. incorrect classifications
correct = 0;
incorrect = 0;

test = readtable('test.txt');

for i=1:30
    sepal_length = test{i, 1};
    sepal_width = test{i, 2};
    petal_length = test{i, 3};
    petal_width = test{i, 4};
    type_string = test{i, 5}{1};

    setosa_result = fired(setosa, sepal_length, sepal_width, petal_length, petal_width);
    versicolor_result = fired(versicolor, sepal_length, sepal_width, petal_length, petal_width);
    virginia_result = fired(virginia, sepal_length, sepal_width, petal_length, petal_width);
    
    if strcmp(type_string, 'Iris-setosa')
        if setosa_result == 0 || versicolor_result == 1 || virginia_result == 1
            incorrect = incorrect+1;
        else
            correct = correct + 1;
        end
    elseif strcmp(type_string, 'Iris-versicolor')
        if setosa_result == 1 || versicolor_result == 1 || virginia_result == 1
            incorrect = incorrect+1;
        else
            correct = correct + 1;
        end
    elseif strcmp(type_string, 'Iris-virginica')
        if setosa_result == 1 || versicolor_result == 1 || virginia_result == 0
            incorrect = incorrect+1;
        else
            correct = correct + 1;
        end
    else
        type = 0;
    end
    
end

