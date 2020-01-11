# lighning

使用mixin

## 概览
### 目录结构

``` bash
.
├─docs
│  └─source
│      ├─_static
│      │  └─images
│      └─_templates
├─pl_examples
│  ├─basic_examples
│  ├─domain_templates
│  ├─full_examples
│  │  └─imagenet
│  └─multi_node_examples
├─pytorch_lightning
│  ├─callbacks
│  ├─core
│  ├─logging
│  ├─overrides
│  ├─pt_overrides
│  ├─root_module
│  ├─testing
│  ├─trainer
│  └─utilities
└─tests
```

### demo

To use lightning do 2 things:  
1. [Define a LightningModule](https://williamfalcon.github.io/pytorch-lightning/LightningModule/RequiredTrainerInterface/)
**WARNING:** This syntax is for version 0.5.0+ where abbreviations were removed.
    ```python
    import os
    
    import torch
    from torch.nn import functional as F
    from torch.utils.data import DataLoader
    from torchvision.datasets import MNIST
    from torchvision import transforms
    
    import pytorch_lightning as pl
    
    class CoolSystem(pl.LightningModule):
    
        def __init__(self):
            super(CoolSystem, self).__init__()
            # not the best model...
            self.l1 = torch.nn.Linear(28 * 28, 10)
    
        def forward(self, x):
            return torch.relu(self.l1(x.view(x.size(0), -1)))
    
        def training_step(self, batch, batch_idx):
            # REQUIRED
            x, y = batch
            y_hat = self.forward(x)
            loss = F.cross_entropy(y_hat, y)
            tensorboard_logs = {'train_loss': loss}
            return {'loss': loss, 'log': tensorboard_logs}
    
        def validation_step(self, batch, batch_idx):
            # OPTIONAL
            x, y = batch
            y_hat = self.forward(x)
            return {'val_loss': F.cross_entropy(y_hat, y)}
    
        def validation_end(self, outputs):
            # OPTIONAL
            avg_loss = torch.stack([x['val_loss'] for x in outputs]).mean()
            tensorboard_logs = {'val_loss': avg_loss}
            return {'avg_val_loss': avg_loss, 'log': tensorboard_logs}
    
        def configure_optimizers(self):
            # REQUIRED
            # can return multiple optimizers and learning_rate schedulers
            # (LBFGS it is automatically supported, no need for closure function)
            return torch.optim.Adam(self.parameters(), lr=0.02)
    
        @pl.data_loader
        def train_dataloader(self):
            # REQUIRED
            return DataLoader(MNIST(os.getcwd(), train=True, download=True, transform=transforms.ToTensor()), batch_size=32)
    
        @pl.data_loader
        def val_dataloader(self):
            # OPTIONAL
            return DataLoader(MNIST(os.getcwd(), train=True, download=True, transform=transforms.ToTensor()), batch_size=32)
    
        @pl.data_loader
        def test_dataloader(self):
            # OPTIONAL
            return DataLoader(MNIST(os.getcwd(), train=False, download=True, transform=transforms.ToTensor()), batch_size=32)
    ```
2. Fit with a [trainer](https://williamfalcon.github.io/pytorch-lightning/Trainer/)    
    ```python
    from pytorch_lightning import Trainer
    
    model = CoolSystem()
    
    # most basic trainer, uses good defaults
    trainer = Trainer()    
    trainer.fit(model)   
    ```

### 入口函数
`Trainer`是通过mixin（受限多重继承）构成，
入口函数`fit`
调用TrainerDPMixin::single_gpu_train
调用Trainer::run_pretrain_routine
调用TrainerTrainLoopMixin::train
调用run_training_epoch，run_training_batch
``` python
class TrainerDPMixin(ABC):
    def single_gpu_train(self, model):
        self.run_pretrain_routine(model)
class Trainer():
    def fit(self, model):
        self.single_gpu_train(model)
    def run_pretrain_routine(self, model):
        self.train()
class TrainerTrainLoopMixin:
    def train(self):
        for epoch in range(self.current_epoch, self.max_epochs):
            self.run_training_epoch()
        model.on_train_end()

    def run_training_epoch(self):
        model.on_epoch_start()
        # run epoch
        for batch_idx, batch in enumerate(self.get_train_dataloader()):
            output = self.run_training_batch(batch, batch_idx)            
            self.run_evaluation(test=self.testing)
        model.on_epoch_end()

    def run_training_batch(self, batch, batch_idx):       
        response = model_ref.on_batch_start(batch)
        for split_idx, split_batch in enumerate(splits):
            self.split_idx = split_idx
            for opt_idx, optimizer in enumerate(self.optimizers):
                def optimizer_closure():
                    output = self.training_forward(
                        split_batch, batch_idx, opt_idx, self.hiddens)
                    model_ref.backward(self.use_amp, closure_loss, optimizer)
                    all_callback_metrics.append(callback_metrics)
                    model_ref.on_after_backward()
                loss = optimizer_closure()
                self.batch_loss_value += loss.item()
                model.optimizer_step(self.current_epoch, batch_idx,
                                         optimizer, opt_idx, optimizer_closure)

        model.on_batch_end()
        self.callback_metrics.update({k: v for d in all_callback_metrics for k, v in d.items()})

```

### core目录简介

lightning
hooks
memory
``` python
class LightningModule(GradInformation, ModelIO, ModelHooks):
    def __init__(self):
        pass
```

