#include <ros/ros.h>

#include <rcomponent/rcomponent.h>
#include <robotnik_msgs/State.h>

#include <std_msgs/String.h>

class RCTemplateCpp : public rcomponent::RComponent
{
public:
  RCTemplateCpp(ros::NodeHandle h);
  virtual ~RCTemplateCpp();

protected:
  /* RComponent stuff */

  //! Setups all the ROS' stuff
  int rosSetup();
  //! Shutdowns all the ROS' stuff
  int rosShutdown();
  //! Reads data a publish several info into different topics
  void rosPublish();
  //! Reads params from params server
  void rosReadParams();

  //! Actions performed on standby state
  void standbyState();
  //! Actions performed on ready state
  void readyState();
  //! Actions performed on the emergency state
  void emergencyState();
  //! Actions performed on Failure state
  void failureState();

protected:
  // Specific node stuff
  //! Public node handle, to receive data
  ros::NodeHandle nh_;
  //! Private node hanlde, to read params and publish data
  ros::NodeHandle pnh_;

  /* Test Publisher
  string test_topic_pub_name_;
  ros::Publisher test_pub_;
  */
};
