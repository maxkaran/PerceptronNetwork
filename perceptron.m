classdef perceptron
    
    properties
        weights = [1 1 1 1]
        threshold = 1
    end
    methods
        function fire = fired(obj, sepal_length, sepal_width, petal_length, petal_width)
            weighting = sepal_length*obj.weights(1) + sepal_width*obj.weights(2) + petal_length*obj.weights(3) + petal_width*obj.weights(4);
            if weighting < obj.threshold
                fire = 1;
            else
                fire = 0;
            end
        end
    end
end