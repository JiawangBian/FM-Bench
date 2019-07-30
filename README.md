# FM-Bench
The source code for "An Evaluation of Feature Matchers for Fundamental Matrix Estimation"


## Publication
An Evaluation of Feature Matchers for Fundamental Matrix Estimation, Jia-Wang Bian, Yu-Huan Wu, Ji Zhao, Yun Liu, Le Zhang, Ming-Ming Cheng, Ian Reid, British Machine Vision Conference (BMVC), 2019

## Data Orgnization

  Root (FM-Bench)
  
    -Dataset
    
        --TUM
      
        --KITTI
      
        --Tanks_and_Temples
      
        --CPC
     
     -Pipeline
     
     -Evaluation
     
     -vlfeat-0.9.21


## Dataset Download

You can download dataset and vlfeat from the link https://1drv.ms/u/s!AiV6XqkxJHE2g3bdq2yQkr2ET4w5?e=oWEjC5


## How to use

    1. Run the example "Pipeline/Pipeline_Demo.m" for results of SIFT-RT-RANSAC.
    
    2. Run the evaluation "Evaluation/Evaluate.m".
    
    3. You can visualize the matching and esimation results for each pair by running "Evaluation/ShowVisualResults.m".
    
    
 ## If you use this work, please cite our paper
 
    @inproceedings{bian2019bench,
      title={An Evaluation of Feature Matchers forFundamental Matrix Estimation},
      author={Bian, Jia-Wang and Wu, Yu-Huan and Zhao, Ji and Liu, Yun and Zhang, Le and Cheng, Ming-Ming and Reid, Ian},
      booktitle= British Machine Vision Conference (BMVC),
      year={2019}
    }

    
    
