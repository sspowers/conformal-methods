Use these commands to run the simulation on solomon.

For any questions, see: https://www.stanford.edu/dept/statistics/cgi-bin/projects/stat-sysadminwiki/index.php/Cluster_Help

-----------------------

GENERAL PRINCIPLES:

This cluster is run by the Department of Statistics to benefit the research needs of its faculty, postdocs, students and collaborators. Although we strive to maintain the system as best as we can, please note that there is no 24/7 support available to watch the system.  Therefore, all users are encouraged to follow some simple rules that will enable a smooth operation of a shared resource such as this.

It always helps to analyze your job requirements as regards memory and disk space. Every cluster has a limit on those resources. Generally, jobs that might swap out to disk are not well suited to our cluster

Do not ssh into the individual compute nodes; clusters are not well-suited for use as individual servers. Use qlogin which will provide an interactive session.

Please keep an eye on submitted jobs.  Sometimes, jobs can hang and block others behind in the queue.  You can kill your job using the qdel command.

Submit jobs in a reasonable number. Even small jobs, when submitted in the thousands can exhibit behavior that you might have not thought of and block queues.

Use the mail flag generously to keep track of your jobs. This is the "m" option to qsub.

https://www.stanford.edu/dept/statistics/cgi-bin/projects/stat-sysadminwiki/index.php/Some_General_Principles_to_Abide_by

---------------------------

solomon_wrap/sh is a script for loading R + calling your R script
master.R is the script we actually want to run

qsub ./solomon_wrap.sh ./master.R
Your job 561921 ("random_forest_simulation") has been submitted

And now, wait!

-bash-4.1$ qstat
job-ID  prior   name       user         state submit/start at     queue                          slots ja-task-ID 
-----------------------------------------------------------------------------------------------------------------
 561921 0.55200 random_for swager       qw    04/14/2014 09:58:38                                    1        

qw means "queued and waiting"

who is ahead of us?

-bash-4.1$ qstat -u "*"
job-ID  prior   name       user         state submit/start at     queue                          slots ja-task-ID 
-----------------------------------------------------------------------------------------------------------------
 521576 0.55200 QLOGIN     mavisli      r     12/04/2013 22:03:55 all.q@solomon-1-0.local            1        
 521577 0.55200 QLOGIN     mavisli      r     12/04/2013 23:13:49 all.q@solomon-2-2.local            1        
 522348 0.56000 expEKsensi dobriban     r     12/19/2013 05:42:58 all.q@solomon-2-2.local            1        
 523875 0.55200 QLOGIN     mavisli      r     01/07/2014 06:58:56 all.q@solomon-0-7.local            1        
 523885 0.55200 QLOGIN     mavisli      r     01/07/2014 13:29:17 all.q@solomon-0-4.local            1        
 523886 0.55200 QLOGIN     mavisli      r     01/07/2014 13:31:57 all.q@solomon-0-7.local            1        
 526082 0.56000 QLOGIN     pegahta      r     01/28/2014 07:58:08 all.q@solomon-0-3.local            1        
 531218 0.55500 QLOGIN     yuvalben     r     03/10/2014 15:57:45 all.q@solomon-0-4.local            1        
 533022 0.55200 QLOGIN     ywli         r     03/14/2014 01:05:16 all.q@solomon-0-4.local            1        
 533408 0.55200 QLOGIN     baijiang     r     03/14/2014 13:38:27 all.q@solomon-1-0.local            1        
 533632 0.55200 QLOGIN     ywli         r     03/18/2014 13:37:30 all.q@solomon-0-5.local            1        
 561216 0.55200 QLOGIN     baijiang     r     03/27/2014 18:56:51 all.q@solomon-0-6.local            1        
 561222 0.55500 QLOGIN     yuvalben     r     03/28/2014 09:07:54 all.q@solomon-1-1.local            1        
 561319 0.55200 QLOGIN     baijiang     r     03/28/2014 16:39:58 all.q@solomon-0-6.local            1        
 561340 0.56000 testrun    sabatti      r     03/29/2014 18:26:51 all.q@solomon-0-3.local            1        
 561374 0.55200 QLOGIN     ywli         r     03/31/2014 01:39:19 all.q@solomon-0-5.local            1        
 561511 0.55200 QLOGIN     ywli         r     04/01/2014 21:41:04 all.q@solomon-0-4.local            1        
 561583 0.55250 USE_Bnd_cv monajemi     r     04/03/2014 14:53:06 all.q@solomon-2-1.local            1        
 561599 0.55250 USE_Pos_cv monajemi     r     04/03/2014 14:53:29 all.q@solomon-0-5.local            1        
 561609 0.55250 USE_C_cvx_ monajemi     r     04/03/2014 15:08:06 all.q@solomon-1-0.local            1        
 561613 0.55250 USE_C_cvx_ monajemi     r     04/03/2014 15:09:06 all.q@solomon-0-6.local            1        
 561752 0.56000 QLOGIN     plata0       dr    04/04/2014 09:51:56 all.q@solomon-1-1.local            1        
 561775 0.55200 QLOGIN     baijiang     r     04/06/2014 15:48:28 all.q@solomon-0-7.local            1        
 561806 0.55200 QLOGIN     baijiang     r     04/07/2014 16:26:36 all.q@solomon-1-1.local            1        
 561824 0.55200 QLOGIN     ywli         r     04/08/2014 11:53:12 all.q@solomon-0-7.local            1        
 561837 0.56000 sim_large  cbp          dr    04/08/2014 14:58:42 all.q@solomon-0-4.local            1        
 561847 0.56000 QLOGIN     lmackey      r     04/09/2014 02:50:39 all.q@solomon-1-2.local            1        
 561852 0.55100 matlab-cmd cfgranda     r     04/09/2014 14:11:09 all.q@solomon-1-2.local            1        
 561855 0.55100 matlab-cmd cfgranda     r     04/09/2014 14:11:24 all.q@solomon-1-2.local            1        
 561859 0.55100 matlab-cmd cfgranda     r     04/09/2014 16:15:37 all.q@solomon-0-2.local            1        
 561867 0.55100 matlab-cmd cfgranda     r     04/10/2014 09:39:58 all.q@solomon-0-0.local            1        
 561868 0.55100 matlab-cmd cfgranda     r     04/10/2014 09:58:43 all.q@solomon-1-1.local            1        
 561870 0.55100 matlab-cmd cfgranda     r     04/10/2014 09:59:13 all.q@solomon-1-1.local            1        
 561871 0.55100 matlab-cmd cfgranda     r     04/10/2014 09:59:13 all.q@solomon-1-1.local            1        
 561872 0.55100 matlab-cmd cfgranda     r     04/10/2014 10:05:43 all.q@solomon-1-2.local            1        
 561876 0.55100 matlab-cmd cfgranda     dr    04/10/2014 16:07:44 all.q@solomon-1-0.local            1        
 561879 0.55100 matlab-cmd cfgranda     dr    04/10/2014 16:07:44 all.q@solomon-1-2.local            1        
 561911 0.55231 early      jingshuw     qw    04/13/2014 18:15:12                                    1        
 561917 0.55214 finrun     nedelec      qw    04/14/2014 09:50:54                                    1        
 561921 0.55200 random_for swager       qw    04/14/2014 09:58:38                                    1        
 561904 0.55100 testrun    plata0       qw    04/12/2014 00:14:19                                    1        
 561905 0.55100 sim_n500   cbp          qw    04/12/2014 14:22:04                                    1        
 561912 0.55100 early      jingshuw     qw    04/13/2014 20:14:05                                    1        
 561920 0.55100 finrun     nedelec      qw    04/14/2014 09:52:14                                    1        
 561906 0.55067 sim_n750   cbp          qw    04/12/2014 14:23:35                                    1        
 561913 0.55067 early      jingshuw     qw    04/13/2014 20:28:41                                    1        
 561915 0.55050 early      jingshuw     qw    04/14/2014 01:38:29                                    1        
 561907 0.55018 matlab-cmd cfgranda     qw    04/13/2014 15:19:40                                    1        
 561908 0.55017 matlab-cmd cfgranda     qw    04/13/2014 15:20:00                                    1        
 561909 0.55015 matlab-cmd cfgranda     qw    04/13/2014 15:20:08                                    1        
 561910 0.55014 matlab-cmd cfgranda     qw    04/13/2014 15:20:18                                    1   