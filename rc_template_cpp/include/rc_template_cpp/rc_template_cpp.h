#include <ros/ros.h>

#include <rcomponent/rcomponent.h>
#include <robotnik_msgs/State.h>

class RCTemplateCpp : public rcomponent::RComponent
{
public:
  RCTemplateCpp(ros::NodeHandle h);
  virtual ~RCTemplateCpp();

protected:
  /* RComponent stuff */

  //! Setups all the ROS' stuff
  virtual int rosSetup();
  //! Shutdowns all the ROS' stuff
  virtual int rosShutdown();
  //! Reads data a publish several info into different topics
  virtual void rosPublish();
  //! Reads params from params server
  virtual void rosReadParams();

  //! Actions performed on standby state
  virtual void standbyState();
  //! Actions performed on ready state
  virtual void readyState();
  //! Actions performed on the emergency state
  virtual void emergencyState();
  //! Actions performed on Failure state
  virtual void failureState();

protected:
  // Specific node stuff
  //! Public node handle, to receive data
  ros::NodeHandle nh_;
  //! Private node hanlde, to read params and publish data
  ros::NodeHandle pnh_;
};
