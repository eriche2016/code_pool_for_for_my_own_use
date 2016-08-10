#torchnet code from [torchnet](https://github.com/torchnet/torchnet)
*torchnet* is a framework for [torch](http://torch.ch) which provides abstraction and boilerplate code(样板代码) for machine learning. It encourages modular programming and code re-use, which reduces chance of bugs, and it makes it straightforward to use asynchronous data loading and efficient multi-GPU computations. Torchnet is written in pure lua, making it easy to install.
Torchnet encourages modular design that clearly separates the dataset, the data loading process, the model, the optimization, and performance measures. These different components are connected in an Engine that implements model training and evaluation.

# Abstractions 
Torchnet implements 5 main types of abstractions:
  - Dataset: provide two functions (1) `size()` returns the number of sampes in the dataset, (2) `get(idx)` function that returns the idx-th sample in the dataset. Below is an overview of all Datasets implemented in Torchnet. We can construct complex data loaders by plugging a dataset into another dataset that perform operations（复合操作） such as dataset concatenation（数据集合拼接）, dataset splitting（数据集划分：训练集，验证集，测试集）, batching of data（数据batching）, resampling of data（数据重采样）, filtering of datset（数据集过滤）, and sample transformations（样本变换， 例如对于图像，有cropping, flippping等等）.
    - BatchDataset: Merge samples into batches.
    - ConcatDataset: concatenates `K` datasets into one.
    - Coroutine BatchDataset:  BatchDataset that provides more control via coroutines.
    - IndexedDataset: Key-value store `Dataset`.
    - ListDataset: Load samples in list via closure
    - ResampleDataset: Arbitarily resampling of a `Dataset`. 
    - ShuffleDataset: Randomly shuffle samples in  `Dataset`.
    - SplitDataset: Splits dataset into disjoint sets.
    - TableDataset: Load samples from a Lua table.
    - TransformDataset: Transform samples via closure.   
    *注：coroutine, 就是协同程序。一个具有多个协同程序的程序在任何时刻只能运行一个协同程序。（1）每个coroutine有自己私有的stack及局部变量。（2）同一时间只有一个coroutine在执行，无需对全局变量加锁。（3）顺序可控，完全由程序控制执行的顺序*

  - DatasetIterators: when performing training and testing, one iterates over all samples in the dataset and performs operations such as parameters updates(`Engines` will do) or accumulation of performance measures(`Meter`s do).  The `DatasetIterator` implements such behaviour with an optional data-dependent filtering(can be implemented via a `filter()` closure). In pratical, we want to perform the data loading asynchronously in multiple threads. The `ParallelDatasetIterator` provides this functionality, which has a predefined number of threads to load data from underlying dataset. If Given suffcient threads, the resulting data iterator always have a sample available for immediate return, which allows one to hide the loading and preprocessing of data for training and testing altogether. 
  - Engine: training/testing machine learning algorithm. This abstraction provides boilerplate logic necessary for training and testing of the models. An instance of `Engine` implements two functions: (1) `train()` that samples data, propagates the data through the model, computes the values of the loss, and updates the parameters. (2) `test()` function that samples the data, propagates the data through the model, and measures the quality of the resulting predictions.  Besides, An `Engine` provides a collection of hooks(implemented as closures)  to plugin experiment specific code. such as performance Meters.  The current Torchnet code contains two Engine implementations: (1) `SGDEngine` that implements training model via SGD and (2) an `OptimEngine` that implements training models via any of the optimizers implemented in the torch/optim package, which includes AdaGrad, Adam, ect. 
  - Meter: meter performance or any other quantity. One may want to measure the time needed to perform a training epoch, the value of loss function averaged over all examples, the area under the ROC curve of a binary classifier, the classifiation error of a multi-class classifier, the precision and recall of a retrieval model, or the normalized discounted cummulative gain of a ranking algorithms. An overview of `Meter`s implemented in torchned are shown below:
      - AUCMeter: Area under ROC curve
      - AverageValueMeter: Average value of variable
      - ClassErrorMeter: classification error 
      - ConfusionMeter: Confusion matrix 
      - MultiLabelConfusionMeter: confusion matrix for multi-label problems 
      - NDCGMeter: Normalized discounted cumulative gain
      - PrecisionAtKMeter: Precision at K
      - PrecisionMeter: Precision at threshold
      - RecallMeter: Recall at threshold.
      - TimeMeter: Elapsed time. 
  - Log: Provides `Log`s for logging experiments:(1) `Log` and (2) `RemoteLog`, both output log information as raw text(to a file or stdout) and as `JSON`.  


## Installation

Please install *torch* first, following instructions on
[torch.ch](http://torch.ch/docs/getting-started.html).  If *torch* is
already installed, make sure you have an up-to-date version of
[*argcheck*](https://github.com/torch/argcheck), otherwise you will get
weird errors at runtime.

Assuming *torch* is already installed, the *torchnet* core is only a set of
lua files, so it is straightforward to install it with *luarocks*
```
luarocks install torchnet
```

To run the MNIST example from the paper, install the `mnist` package:
```
luarocks install mnist
```

`cd` into the installed `torchnet` package directory and run:
```
th example/mnist.lua
```
