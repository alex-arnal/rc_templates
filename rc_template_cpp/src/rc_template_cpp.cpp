#include <rc_template_cpp/rc_template_cpp.h>

RCTemplateCpp::RCTemplateCpp(ros::NodeHandle h) : RComponent(h), nh_(h), pnh_("~")
{
    rosReadParams();
}

RCTemplateCpp::~RCTemplateCpp()
{
    // TODO: create an example of action client
    // TODO: create an example of action server
    // TODO: create an example of service client
    // TODO: create an example of service server
}

int RCTemplateCpp::rosSetup()
{
    if (RComponent::rosSetup() == rcomponent::OK)
    {
        /* Test Publisher
        test_pub_ = pnh_.advertise<std_msgs::String>(test_topic_pub_name_, 1);
        */

        /* Test Subscriber
        test_sub_ = pnh_.subscribe<std_msgs::String>(test_topic_sub_name_, 1,
                                                     &RCTemplateCpp::testSubCb, this);
        */
    }
}

int RCTemplateCpp::rosShutdown()
{
    RComponent::rosShutdown();
}

void RCTemplateCpp::rosPublish()
{
    RComponent::rosPublish();
}

void RCTemplateCpp::rosReadParams()
{
    /* Test Publisher
    std::string default_test_topic_pub_name = "test_topic_name";
    readParam(pnh_, "test_topic_pub_name", test_topic_pub_name_, default_test_topic_pub_name, true);
    */

    /* Test Subscriber   
    std::string default_test_topic_sub_name = "test_topic_name";
    readParam(pnh_, "test_topic_sub_name", test_topic_sub_name_, default_test_topic_sub_name, true);
    */
}

void RCTemplateCpp::standbyState()
{
    switchToState(robotnik_msgs::State::READY_STATE);
}
void RCTemplateCpp::readyState()
{
    /* Test Publisher
    std_msgs::String test_pub_msg;
    test_pub_msg.data = "Test";

    test_pub_.publish(test_pub_msg);
    */
}

void RCTemplateCpp::emergencyState()
{
}

void RCTemplateCpp::failureState()
{
}

/* Test Subscriber
void RCTemplateCpp::testSubCb(const std_msgs::String::ConstPtr &msg)
{
    RCOMPONENT_INFO("This should be print when a msg is received");
}
*/
