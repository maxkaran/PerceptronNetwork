classdef perceptron
    
    properties
        weights = [1 1];
        threshold = 0.5;
    end
    methods
        function fire = fired(obj, sepal_width, petal_width)
            weighting = sepal_width*obj.weights(1) + petal_width*obj.weights(2);
            if weighting > obj.threshold
                fire = 1;
            else
                fire = 0;
            end
        end
    end
end