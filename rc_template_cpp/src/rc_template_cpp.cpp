#include <rc_template_cpp/rc_template_cpp.h>

RCTemplateCpp::RCTemplateCpp(ros::NodeHandle h) : RComponent(h), nh_(h), pnh_("~")
{
    component_name.assign(pnh_.getNamespace());
    rosReadParams();
}

RCTemplateCpp::~RCTemplateCpp()
{
    // TODO: create an example of publisher
    // TODO: create an example of subscriber
    // TODO: create an example of action client
    // TODO: create an example of action server
    // TODO: create an example of service client
    // TODO: create an example of service server
}

int RCTemplateCpp::rosSetup()
{
    RComponent::rosSetup();
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
    // RComponent::rosReadParams();
}

void RCTemplateCpp::standbyState()
{
    switchToState(robotnik_msgs::State::READY_STATE);
}
void RCTemplateCpp::readyState()
{
}

void RCTemplateCpp::emergencyState()
{
}

void RCTemplateCpp::failureState()
{
}
