# Assignment-1

## Avalanche Hazard Prediction

This paper investigates the use of neural networks to predict observed avalanches one day in advance. The study
utilizes a 15-year archive of avalanche forecasts and develops four neural network models. The first model, which
incorporated all available variables, achieved an accuracy of 74.59%. However, despite this moderate performance,
the model exhibited weak precision and recall for the moderate and High class, making it unsuitable for practical
application. The remaining models were trained on subsets of predictors. Predictor Set 1 (Longitude:Incline)
achieved an accuracy of 74,82% but suffered from poor precision and recall across moderate and high classes.
Predictor Set 2 (Air.Temp:Summit.Wind.Speed) performed marginally better at 74.89%, though its precision and
recall remained low for the minor classes. Predictor Set 3 (Max.Temp.Grad:Snow.Temp) obtained the highest
accuracy at 75.11% from the three, yet it too was limited by weak recall and precision on the minority classes. The
overall imperfectness in performance of the models is largely attributable to class imbalance in the dataset, as severe
avalanche conditions were rare, leading the models to bias toward the more frequent classes
![Avalanche Hazard Classes](R.jpeg)
