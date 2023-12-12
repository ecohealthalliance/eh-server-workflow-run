# Intallation

You can install the released version of rslurm from CRAN with
` install.packages("rslurm")`  or  ` # install.packages("devtools") devtools::install_github("earthlab/rslurm") ` . 

Example usage 

Our cluster information 
```
espirado@controller:~/slurmr$ sinfo
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
all*         up    4:00:00      4   idle worker[01-04]
non-gpu      up    4:00:00      4   idle worker[01-04]
gl           up    4:00:00      4   idle worker[01-04]
gpu          up    4:00:00      2   idle worker[03-04]

```

The clusters are set in the following way 
PartitionName=non-gpu - PreemptMode=CANCEL
PartitionName=gl  - PreemptMode=REQUEUE
PartitionName=gpu - Priority=1000 

We will use the example from  [earth tutorial](https://www.earthdatascience.org/rslurm/articles/rslurm.html)


This is the pre-generated slurm script to run the job 

```

#!/bin/bash
#
#SBATCH --array=0-1
#SBATCH --cpus-per-task=2
#SBATCH --job-name=test_apply
#SBATCH --output=slurm_%a.out
/usr/local/lib/R/bin/Rscript --vanilla slurm_run.R


```

Based on our cluster configuration we can modify this script to add extra variables for slurm including partitions etc
```

#!/bin/bash
#
#SBATCH --array=0-1
#SBATCH --cpus-per-task=2
#SBATCH --partition=gpu,gl,non-gpu,all
#SBATCH --job-name=test_apply
#SBATCH --output=slurm_%a.out
/usr/local/lib/R/bin/Rscript --vanilla slurm_run.R

```

The partitions have been configured in this format to resource on host machine 

```
scontrol show nodes
NodeName=worker01 Arch=x86_64 CoresPerSocket=1 
   CPUAlloc=0 CPUEfctv=8 CPUTot=8 CPULoad=0.94
   AvailableFeatures=(null)
   ActiveFeatures=(null)
   Gres=(null)
   NodeAddr=worker01 NodeHostName=worker01 Version=23.02.4
   OS=Linux 5.4.0-166-generic #183-Ubuntu SMP Mon Oct 2 11:28:33 UTC 2023 
   RealMemory=51500 AllocMem=0 FreeMem=126059 Sockets=8 Boards=1
   State=IDLE ThreadsPerCore=1 TmpDisk=0 Weight=1 Owner=N/A MCS_label=N/A
   Partitions=all,non-gpu,gl 
   BootTime=2023-11-21T11:59:55 SlurmdStartTime=2023-12-11T12:26:56
   LastBusyTime=2023-12-11T14:03:07 ResumeAfterTime=None
   CfgTRES=cpu=8,mem=51500M,billing=8
   AllocTRES=
   CapWatts=n/a
   CurrentWatts=0 AveWatts=0
   ExtSensorsJoules=n/s ExtSensorsWatts=0 ExtSensorsTemp=n/s

NodeName=worker02 Arch=x86_64 CoresPerSocket=1 
   CPUAlloc=0 CPUEfctv=8 CPUTot=8 CPULoad=0.94
   AvailableFeatures=(null)
   ActiveFeatures=(null)
   Gres=(null)
   NodeAddr=worker02 NodeHostName=worker02 Version=23.02.4
   OS=Linux 5.4.0-166-generic #183-Ubuntu SMP Mon Oct 2 11:28:33 UTC 2023 
   RealMemory=41500 AllocMem=0 FreeMem=126059 Sockets=8 Boards=1
   State=IDLE ThreadsPerCore=1 TmpDisk=0 Weight=1 Owner=N/A MCS_label=N/A
   Partitions=all,non-gpu,gl 
   BootTime=2023-11-21T11:59:55 SlurmdStartTime=2023-12-11T12:26:56
   LastBusyTime=2023-12-11T14:03:07 ResumeAfterTime=None
   CfgTRES=cpu=8,mem=41500M,billing=8
   AllocTRES=
   CapWatts=n/a
   CurrentWatts=0 AveWatts=0
   ExtSensorsJoules=n/s ExtSensorsWatts=0 ExtSensorsTemp=n/s

NodeName=worker03 Arch=x86_64 CoresPerSocket=1 
   CPUAlloc=0 CPUEfctv=8 CPUTot=8 CPULoad=0.94
   AvailableFeatures=(null)
   ActiveFeatures=(null)
   Gres=(null)
   NodeAddr=worker03 NodeHostName=worker03 Version=23.02.4
   OS=Linux 5.4.0-166-generic #183-Ubuntu SMP Mon Oct 2 11:28:33 UTC 2023 
   RealMemory=41500 AllocMem=0 FreeMem=126059 Sockets=8 Boards=1
   State=IDLE ThreadsPerCore=1 TmpDisk=0 Weight=1 Owner=N/A MCS_label=N/A
   Partitions=all,non-gpu,gl,gpu 
   BootTime=2023-11-21T11:59:55 SlurmdStartTime=2023-12-11T12:26:56
   LastBusyTime=2023-12-11T12:27:17 ResumeAfterTime=None
   CfgTRES=cpu=8,mem=41500M,billing=8
   AllocTRES=
   CapWatts=n/a
   CurrentWatts=0 AveWatts=0
   ExtSensorsJoules=n/s ExtSensorsWatts=0 ExtSensorsTemp=n/s

NodeName=worker04 Arch=x86_64 CoresPerSocket=1 
   CPUAlloc=0 CPUEfctv=8 CPUTot=8 CPULoad=0.94
   AvailableFeatures=(null)
   ActiveFeatures=(null)
   Gres=(null)
   NodeAddr=worker04 NodeHostName=worker04 Version=23.02.4
   OS=Linux 5.4.0-166-generic #183-Ubuntu SMP Mon Oct 2 11:28:33 UTC 2023 
   RealMemory=41500 AllocMem=0 FreeMem=126059 Sockets=8 Boards=1
   State=IDLE ThreadsPerCore=1 TmpDisk=0 Weight=1 Owner=N/A MCS_label=N/A
   Partitions=all,non-gpu,gl,gpu 
   BootTime=2023-11-21T11:59:55 SlurmdStartTime=2023-12-11T12:26:56
   LastBusyTime=2023-12-11T12:27:17 ResumeAfterTime=None
   CfgTRES=cpu=8,mem=41500M,billing=8
   AllocTRES=
   CapWatts=n/a
   CurrentWatts=0 AveWatts=0
   ExtSensorsJoules=n/s ExtSensorsWatts=0 ExtSensorsTemp=n/s

```

The partitions have different capabilities 

