import pandas
from sklearn import model_selection
from sklearn.linear_model import LogisticRegression
import pickle
import os
import numpy as np
from keras.preprocessing import image

filename = 'image_classifier_big.sav'
print("Loading model....")
classifier = pickle.load(open(filename, 'rb'))
print("Model loaded.")

DIRECTORY_NAME = "D:/Extras/DS/chest_xray/test/testimages"
print("Reading files..")
print("Analyzing image..")
for file in os.listdir(DIRECTORY_NAME):
	test_img = image.load_img(DIRECTORY_NAME + "/" + file, target_size=(64, 64))
	test_img = image.img_to_array(test_img)
	test_img = np.expand_dims(test_img, axis=0)
	result = classifier.predict(test_img)

	if result[0][0] == 1:
		print(f">> {file} :   Pneumonia Patient")
	else:
		print(f">> {file} :   Normal Patient")

print("Done.")