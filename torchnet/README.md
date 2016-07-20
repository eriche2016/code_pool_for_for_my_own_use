#torchnet code from [torchnet](https://github.com/torchnet/torchnet)
*torchnet* is a framework for [torch](http://torch.ch) which provides abstraction and boilerplate code for machine learning. It encourages modular programming and code re-use, which reduces chance of bugs, and it makes it straightforward to use asynchronous data loading and efficient multi-GPU computations. Torchnet is written in pure lua, making it easy to install.
Torchnet encourages modular design that clearly separates the dataset, the data loading process, the model, the optimization, and performance measures. These different components are connected in an Engine that implements model training and evaluation.

# Abstractions 
Torchnet implements 5 main types of abstractions:
  - Dataset: provide two functions (1) `size()` returns the number of sampes in the dataset, (2) `get(idx)` function that returns the idx-th sample in the dataset. Below is an overview of all Datasets implemented in Torchnet. We can construct complex data loaders by plugging a dataset into another dataset that perform operations such as dataset concatenation, dataset splitting, batching of data, resampling of data, filtering of datset, and sample transformations.
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

  - DatasetIterators: when performing training and testing, one iterates over all samples in the dataset and performs operations such as parameters updates(`Engines` will do) or accumulation of performance measures(`Meter`s do).  The `DatasetIterator` implements such behaviour with an optional data-dependent filtering(can be implemented via a `filter()` closure). In pratical, we want to perform the data loading asynchronously in multiple threads. The `ParallelDatasetIterator` provides this functionality, which has a predefined number of threads to load data from underlying dataset. If Given suffcient threads, the resulting data iterator always have a sample available for immediate return, which allows one to hide the loading dan preprocessing of data for training and testing altogether. 
  - Engine: training/testing machine learning algorithm. 
  - Meter: meter performance or any other quantity.
  - Log: output performance or any other string to file / disk in a consistent manner.
