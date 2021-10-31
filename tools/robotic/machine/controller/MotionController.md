# Motion



### Proportional and Integral (PI) Controller

The following figure shows a PI controller.

![ServoStudio_Velocity_0-PI-annotated](http://servotronix.com/html/Help_CDHD_EN/HTML/ImagesExt/image120_207.jpg)

Figure ‎6-26.    Velocity Control – PI Controller

The PI controller is a unity feedback system with no pre-filter. The proportional gain  (KVP) stabilizes the system. The integral gain (KVI) compensates for the steady state error.

The controller parameters KVP and KVI and KVFR are tuned by trial and error.

Refer to VarCom VELCONTROLMODE 0.



## Velocity Control Loop Tuning

### Pseudo Derivative Feedback and Feedforward (PDFF) Controller

The following figure shows a PDFF controller. Like the PI controller, it has an integral gain (KVI) and a proportional gain (KVP), with the addition of a feedforward, KVFR.

![ServoStudio_Velocity_1-PDFF-annotated](http://servotronix.com/html/Help_CDHD_EN/HTML/ImagesExt/image120_208.png)

Figure ‎6-27.    Velocity Control – PDFF Controller

When an application requires maximum responsiveness, less integral gain is required, and KVFR can be set to a higher value. When an application requires maximum low-frequency stiffness, KVFR is set to a lower value, which allows much higher integral gain without inducing overshoot. This will also cause the system to be slower in responding to the command. A mid-range KVFR value is usually suitable for motion control applications.

PDFF is a generalized controller. The controller parameters KVP , KVI and KVFR are tuned by trial and error.

Refer to VarCom VELCONTROLMODE 1.

### Standard Pole Placement (PP) Controller

For PP controller tuning, only two parameters are needed: load inertia ratio (LMJR) and closed-loop system bandwidth (BW).

![ServoStudio_Velocity_2-StdPole-annotated](http://servotronix.com/html/Help_CDHD_EN/HTML/ImagesExt/image120_209.png)

Figure ‎6-28.    Velocity Control – Standard PP Controller

For the controller design, it is not necessary to know the load inertia. The parameter can be easily tuned, as described in the following procedure.

Use the following procedure to manually tune the PP Velocity Controller.

More:

[Manual Tuning of the PP Velocity Controller](http://servotronix.com/html/Help_CDHD_EN/HTML/Documents/manualtuningoftheppvelocitycontroller.htm)

## misc
[Motion](http://servotronix.com/html/Help_CDHD_EN/HTML/Documents/motion.htm) > [Velocity Control Loop Tuning](http://servotronix.com/html/Help_CDHD_EN/HTML/Documents/velocitycontrollooptuning.htm) > [Pseudo Derivative Feedback and Feedforward (PDFF) Controller](http://servotronix.com/html/Help_CDHD_EN/HTML/Documents/pseudoderivativefeedbackandfeedforwardpdffcontroller.htm)