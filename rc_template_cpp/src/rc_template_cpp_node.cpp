#include <rc_template_cpp/rc_template_cpp.h>
int main(int argc, char **argv)
{
    ros::init(argc, argv, "rc_template_cpp");
    ros::NodeHandle n;

    RCTemplateCpp rc_template_cpp(n);
    rc_template_cpp.start();
}