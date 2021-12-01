# Instructions:

Thank you for reading this.

For the natural language processing aspect of our project, we compared the text section of the complaint reports (cr_text) against the related complaint information. In detail, we observed the relationship between the topics in cr_text, the location of the allegation, as well as the race of the complainant.

Our team decided to operate on the Google Colab platform by implementing BERTopic along with nltk for pre-processing, cleaning, visualizing, generating, and analyzing the topics that the custom-made BERTopic model generated. 

In order to ensure that you won't encounter any problems or errors while opening the files using Google Colab and BERTopic on your computer, please make sure to
carefully read the next steps.

## Prerequisites
- Have an active and valid account and connection to Google Colab.
- Open the Google Colab notebook on your google colab account by downloading the following file: [Google Colab Notebook file](src/checkpoint_5.ipynb)
- You can also publically access the notebook by following this link: https://colab.research.google.com/drive/1Obuza0CbIRiAX3XQblDqmau7K-vfn29C?usp=sharing

## Next steps:
- Use the following link or download the file as instructed in order to access the notebook on Google Colab.
- https://colab.research.google.com/drive/1Obuza0CbIRiAX3XQblDqmau7K-vfn29C?usp=sharing
- Run each block of code or segment from the begining, some files will download on your notebook that are required when importing libraries and using BERTopic.

## Results & Analysis:
Following the completion of checkpoint 5, our findings lead to a number of fairly obvious conclusions. The first of which is that the black and hispanic populations both have much higher frequencies of complaints in which they described being injured or having things stolen by the police. This very possibly points to racism in the police force, but we do not have the data required to substantiate this claim. These complaints also link up with our Checkpoint 3 visualization, in which we note that the TRRs of certain communities like Austin have largely black or hispanic as the subject race. 

For communities, apart from the high incidence of complaints of injuries in communities with high TRR rates, the data is a bit too sparse to make any real conclusions. It is possible to draw some inference from things like indebtedness to the city, but some communities only have a couple of complaints.


