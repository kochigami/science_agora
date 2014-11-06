#include "ros/ros.h"
#include <unistd.h>
#include <iostream>
#include <iomanip>
#include <string.h>
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include <opencv2/opencv.hpp>
#include <opencv2/nonfree/nonfree.hpp>
#include <image_transport/image_transport.h>
#include <cv_bridge/cv_bridge.h>
#include <sensor_msgs/Image.h>
#include <sensor_msgs/CameraInfo.h>
#include <sensor_msgs/image_encodings.h>
#include <std_msgs/String.h>
#include <rospack/rospack.h>
#include <face_detector_mono/RectArray.h>
#include <face_detector_mono/Rect.h>


//http://whoopsidaisies.hatenablog.com/entry/2013/12/07/135810#SampleCode
//http:wiki.ros.org/cv_bridge/Tutorials/UsingCvBridgeToConvertBetweenROSImagesAndOpenCVImages
using namespace std;
using namespace ros;
using namespace cv;


typedef struct TD{
  TD(){
  }
  TD(cv::Mat temp, cv::Ptr<cv::FeatureDetector> detector,cv::Ptr<cv::DescriptorExtractor> extractor, const char *_name){
    img = temp;
    detector->detect(img, keypoint);
    extractor->compute(img, keypoint, descriptor);
    name=_name;
  }
  cv::Mat img;
  std::vector<cv::KeyPoint> keypoint;
  cv::Mat descriptor;
  std::string name;
} template_data;

class LearningObject
{
public:
  ros::NodeHandle nh_;
  ros::Publisher character_pub;
  ros::Publisher point_pub;
  ros::Publisher diary_pub;
  ros::Publisher conversation_finished_pub;
  ros::Subscriber picture_permission_sub;
  ros::Subscriber friend_name_sub;
  ros::Subscriber friend_favorite_sub;
  ros::Subscriber friend_subject_sub;
  ros::Subscriber friend_food_sub;
  ros::Subscriber friend_color_sub;
  
  //added 
  ros::Subscriber nao_diary_angry_mode_sub;
  ros::Subscriber nao_secret_mode_name_sub;
  ros::Subscriber nao_secret_mode_favorite_sub;
  ros::Subscriber nao_secret_mode_subject_sub;
  //added end
  std::vector<template_data> template_imgs;
  image_transport::ImageTransport it_;
  image_transport::Subscriber image_sub_;
  cv::Ptr<cv::FeatureDetector> detector;
  cv::Ptr<cv::DescriptorExtractor> extractor;
  cv::Ptr<cv::DescriptorMatcher> matcher;
  cv_bridge::CvImagePtr cv_ptr;
  std::vector<cv::KeyPoint> inputdata_keypoint;
  cv::Mat inputdata_descriptor;
  cv::Mat input_img;
  string friendname;
  string friendfavorite;
  string friendsubject;
  string friendfood;
  string friendcolor;
  std::string default_template_file_name;
  int key;
  int pic_count;
  int count2;
  int nao_diary_angry_mode;
  int nao_secret_name;
  int nao_secret_favorite;
  int nao_secret_subject;
  void filereading(){
    char fname[256];
    string hiragana;
    ROS_INFO("before read");
    for(int i=1; i<78; i++){   
      //sprintf(fname, "/home/kochigami/ros/groovy/cultural_festival/src/image%04d.png",i);
      //sprintf(fname, "/home/kochigami/ros/groovy/karuta/img%04d.png",i);
      sprintf(fname, (default_template_file_name+std::string("/karuta/img%04d.png")).c_str(),i);
      //std::ofstream test("/home/kochigami/ros/groovy/cultural_festival/diary/test.txt");
      //test<<fname<<std::endl;
      //ROS_INFO("template file name: %s", fname);
      
      cv::Mat dst_img=cv::imread(fname);
      if(i==1) hiragana="あ"; if(i==2) hiragana="い"; if(i==3) hiragana="う";
      if(i==4) hiragana="え"; if(i==5) hiragana="お"; if(i==6) hiragana="か";
      if(i==7) hiragana="き"; if(i==8) hiragana="く"; if(i==9) hiragana="け";
      if(i==10) hiragana="こ";if(i==11) hiragana="さ";if(i==12) hiragana="し";
      if(i==13) hiragana="す";if(i==14) hiragana="せ";if(i==15) hiragana="そ";
      if(i==16) hiragana="た";if(i==17) hiragana="ち";if(i==18) hiragana="つ";
      if(i==19) hiragana="て";if(i==20) hiragana="と";if(i==21) hiragana="な";
      if(i==22) hiragana="に";if(i==23) hiragana="ぬ";if(i==24) hiragana="ね";
      if(i==25) hiragana="の";if(i==26) hiragana="は";if(i==27) hiragana="ひ";
      if(i==28) hiragana="ふ";if(i==29) hiragana="へ";if(i==30) hiragana="ほ";
      if(i==31) hiragana="ま";if(i==32) hiragana="み";if(i==33) hiragana="む";
      if(i==34) hiragana="め";if(i==35) hiragana="も";if(i==36) hiragana="や";
      if(i==37) hiragana="ゆ";if(i==38) hiragana="よ";if(i==39) hiragana="ら";
      if(i==40) hiragana="り";if(i==41) hiragana="る";if(i==42) hiragana="れ";
      if(i==43) hiragana="ろ";if(i==44) hiragana="わ";if(i==45) hiragana="を";
      if(i==46) hiragana="ん";if(i==47) hiragana="おわり";if(i==48) hiragana="おしまい"; 
      if(i==49) hiragana="が";if(i==50) hiragana="ぎ";if(i==51) hiragana="ぐ";
      if(i==52) hiragana="げ";if(i==53) hiragana="ご";if(i==54) hiragana="ざ";
      if(i==55) hiragana="じ";if(i==56) hiragana="ず";if(i==57) hiragana="ぜ";
      if(i==58) hiragana="ぞ";if(i==59) hiragana="だ";if(i==60) hiragana="ぢ";
      if(i==61) hiragana="づ";if(i==62) hiragana="で";if(i==63) hiragana="ど";
      if(i==64) hiragana="ば";if(i==65) hiragana="び";if(i==66) hiragana="ぶ";
      if(i==67) hiragana="べ";if(i==68) hiragana="ぼ";if(i==69) hiragana="ゃ";
      if(i==70) hiragana="ゅ";if(i==71) hiragana="ょ";if(i==72) hiragana="　";
      if(i==73) hiragana="ぱ";if(i==74) hiragana="ぴ";if(i==75) hiragana="ぷ";
      if(i==76) hiragana="ぺ";if(i==77) hiragana="ぽ";

      template_imgs.push_back(template_data(dst_img, detector, extractor, hiragana.c_str()));
    }
    ROS_INFO("Let's start"); 
  }
  
  LearningObject()
    :it_(nh_),detector (cv::FeatureDetector::create("SIFT")), extractor (cv::DescriptorExtractor::create("SIFT")), matcher (cv::DescriptorMatcher::create("BruteForce"))
  {
    
    rospack::Rospack rp;
    std::vector<std::string> search_path;
    rp.getSearchPathFromEnv(search_path);
    rp.crawl(search_path, 1);
    std::string path;
    if (rp.find("science_agora",path)==true) default_template_file_name = path;
    
    key=0;
    count2=0;
    friendname="うおりゃあ";
    friendfavorite="うありゃあ";
    friendsubject="うおりゃあ";
    friendfood="うありゃあ";
    friendcolor="うおりゃあ";
    
    //added
    nao_secret_name=0;
    nao_secret_favorite=0;
    nao_secret_subject=0;
    nao_diary_angry_mode=0;
    //added end
    filereading();
    image_sub_ = it_.subscribe("/image_raw", 1, 
			       &LearningObject::FeatureMatching, this);
    character_pub = nh_.advertise<std_msgs::String>("/nao_character_learn", 10);
    point_pub =nh_.advertise<face_detector_mono::RectArray>("/nao_karuta_size",10);
    diary_pub = nh_.advertise<std_msgs::String>("/nao_diary_write_finish", 100);
    conversation_finished_pub = nh_.advertise<std_msgs::String>("/conversation_finished", 10);
    picture_permission_sub = nh_.subscribe("/nao_taking_picture_permission", 1000, &LearningObject::PictureCb, this);
    friend_name_sub = nh_.subscribe("/nao_friend_tenki", 10, &LearningObject::FriendNameCb, this);
    friend_favorite_sub = nh_.subscribe("/nao_friend_comefrom", 10, &LearningObject::FriendFavoriteCb, this);
    friend_subject_sub = nh_.subscribe("/nao_friend_food", 10, &LearningObject::FriendSubjectCb, this);
    friend_food_sub = nh_.subscribe("/nao_friend_subject", 10, &LearningObject::FriendFoodCb, this);
    friend_color_sub = nh_.subscribe("/nao_friend_image", 10, &LearningObject::FriendColorCb, this);
    //added 
    nao_diary_angry_mode_sub = nh_.subscribe("/nao_diary_angry", 10, &LearningObject::NaoDiaryAngryModeCb, this);
    nao_secret_mode_name_sub = nh_.subscribe("/nao_secret_mode_name", 10, &LearningObject::NaoSecretModeName ,this);
    nao_secret_mode_favorite_sub = nh_.subscribe("/nao_secret_mode_favorite", 10, &LearningObject::NaoSecretModeFavorite ,this);
    nao_secret_mode_subject_sub = nh_.subscribe("/nao_secret_mode_subject", 10, &LearningObject::NaoSecretModeSubject, this);
    //added end
    cv::initModule_nonfree(); // SIFTの初期化
  }

  void NaoSecretModeName(const std_msgs::String::ConstPtr& msg){
    nao_secret_name=1;
  }
  
  void NaoSecretModeFavorite(const std_msgs::String::ConstPtr& msg){
    nao_secret_favorite=1;
  }

  void NaoSecretModeSubject(const std_msgs::String::ConstPtr& msg){
    nao_secret_subject=1;
  }
  
  void PictureCb(const std_msgs::String::ConstPtr& msg){
    key=1;
    pic_count=0;
    usleep(3000000);
    ROS_INFO("Let's take a picture!");
  }

  void FriendNameCb(const std_msgs::String::ConstPtr& msg){
    friendname = msg->data.c_str();
  }

  void FriendFavoriteCb(const std_msgs::String::ConstPtr& msg){
    friendfavorite = msg->data.c_str();
  }
  void FriendSubjectCb(const std_msgs::String::ConstPtr& msg){
    friendsubject = msg->data.c_str();
  }
  void FriendFoodCb(const std_msgs::String::ConstPtr& msg){
    friendfood = msg->data.c_str();
  }
  void FriendColorCb(const std_msgs::String::ConstPtr& msg){
    friendcolor = msg->data.c_str();
  }
  

  //added
  void NaoDiaryAngryModeCb(const std_msgs::String::ConstPtr& msg){
    ROS_INFO("%s",msg->data.c_str());
    if(strcmp(msg->data.c_str(),"なおおこ") == 0){
    nao_diary_angry_mode=1;
    }else {
      nao_diary_angry_mode=2;
    }
  }
  //added end
  void FeatureMatching(const sensor_msgs::ImageConstPtr& msg){
    try
      {
	cv_ptr = cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::BGR8);
      }
    catch (cv_bridge::Exception& e)
      {
	ROS_ERROR("cv_bridge exception: %s", e.what());
	return;
      }
   
    input_img = cv_ptr->image.clone();
    cv::Mat temp_img = input_img.clone();
    
    if(!temp_img.empty()){
      cv::imshow("result", temp_img);
      cv::waitKey(20);
    }
    else{
      ROS_INFO("temp_img is empty");
      return;
    }

    // 特徴点抽出                       
    detector->detect(input_img, inputdata_keypoint);
    // 特徴記述      
    extractor->compute(input_img, inputdata_keypoint, inputdata_descriptor);
    // マッチング
    int count=0;
    //int count2=0;
    std_msgs::String hiragana_msg;
    face_detector_mono::RectArray msgs;
    
    // for  (std::vector<template_data>::iterator pt= template_imgs.begin(); pt !=template_imgs.end(); pt++){
    
    #pragma omp parallel for
    for(int i=0; i< template_imgs.size(); i++){
      //std::vector<template_data>::iterator pt = &template_imgs.at(i);
      template_data *pt = &template_imgs.at(i);
      char window_name[16];
      // sprintf(window_name, "template%d",count+1);
      // if(!pt->img.empty()){
      // 	cv::imshow(window_name, pt->img);
      // 	cv::waitKey(20); //書くのを忘れていた　忘れるとimshowの結果が出てこない
      // }
      // else{
      // 	ROS_INFO("template_img is empty");
      // 	return;
      // }
      
      int count = i;//count++;
      std::vector<cv::DMatch> dmatch;
      matcher->match(pt->descriptor, inputdata_descriptor, dmatch);
      double max_dist=0, min_dist=50;
      
      for(int p=0; p< pt->descriptor.rows; p++)
	{
	  double dist=dmatch[p].distance;
	  if(dist < min_dist) min_dist=dist;
	  if(dist > max_dist) max_dist=dist;
	}
      
      std::vector<cv::DMatch> good_matches;
      for(int p=0; p< pt->descriptor.rows; p++){
	if(dmatch[p].distance <= 2*min_dist) good_matches.push_back(dmatch[p]);
	//1.2
      }
      
      cv::Mat out;
      cv::drawMatches(pt->img, pt->keypoint, input_img, inputdata_keypoint, good_matches, out, cv::Scalar::all(-1),cv:: Scalar::all(-1), vector<char>(), cv::DrawMatchesFlags::NOT_DRAW_SINGLE_POINTS );
      std::vector<Point2f> obj;
      std::vector<Point2f> scene;
      int count_p;
      for(count_p = 0; count_p < good_matches.size(); count_p++ )
        {
          //-- Get the keypoints from the good matches                         
          obj.push_back( pt->keypoint[ good_matches[count_p].queryIdx ].pt );
          scene.push_back( inputdata_keypoint[ good_matches[count_p].trainIdx ].pt );
	}

      //15
      if(good_matches.size()<12){
	// sprintf(window_name, "match_result%d",count);
	// cv::imshow(window_name, out);
       	continue;
      }
      
      //test start
      Mat H = findHomography( obj, scene, CV_RANSAC );
      //-- Get the corners from the image_1 ( the object to be "detected" )
      std::vector<Point2f> obj_corners(4);
      obj_corners[0] = cvPoint(0,0); obj_corners[1] = cvPoint( pt->img.cols, 0 );
      obj_corners[2] = cvPoint( pt->img.cols, pt->img.rows ); obj_corners[3] = cvPoint( 0, pt->img.rows );
      std::vector<Point2f> scene_corners(4);

      perspectiveTransform( obj_corners, scene_corners, H);

      //-- Draw lines between the corners (the mapped object in the scene - image_2 )
      line( out, scene_corners[0] + Point2f( pt->img.cols, 0), scene_corners[1] + Point2f( pt->img.cols, 0), Scalar(0, 255, 0), 4 );
      line( out, scene_corners[1] + Point2f( pt->img.cols, 0), scene_corners[2] + Point2f(pt->img.cols, 0), Scalar( 0, 255, 0), 4 );
      line( out, scene_corners[2] + Point2f( pt->img.cols, 0), scene_corners[3] + Point2f(pt->img.cols, 0), Scalar( 0, 255, 0), 4 );
      line( out, scene_corners[3] + Point2f( pt->img.cols, 0), scene_corners[0] + Point2f(pt->img.cols, 0), Scalar( 0, 255, 0), 4 );
      sprintf(window_name, "matches%d", count);
      cv::imshow(window_name, out);
      face_detector_mono::Rect a;
      a.x = (scene_corners[1].x + scene_corners[3].x)/2; 
      a.y = (scene_corners[1].y + scene_corners[3].y)/2; 
      a.height=sqrt((scene_corners[1].y - scene_corners[2].y)*(scene_corners[1].y - scene_corners[2].y)+(scene_corners[1].x - scene_corners[2].x)*(scene_corners[1].x - scene_corners[2].x)); 
      a.width=sqrt((scene_corners[3].y - scene_corners[2].y)*(scene_corners[3].y - scene_corners[2].y)+(scene_corners[3].x - scene_corners[2].x)*(scene_corners[3].x - scene_corners[2].x));
      msgs.rects.push_back(a);
     
      //////////////必要ならコメントアウト外して/////////////////////
      //sprintf(window_name, "match_result%d",count);
      //cv::imshow(window_name, out);
      /////////////ここまで//////////////////////////////////////////


	//cv::waitKey(20); //書くのを忘れていた　忘れるとimshowの結果が出てこない
	// }
      // else{
      // ROS_INFO("output_img is empty");
      // return;
      //  }
            
      hiragana_msg.data = pt->name;
      
    }
    point_pub.publish(msgs);
    //文字を返すstd_msg::Stringタイプのrostopicをpublishする
    character_pub.publish(hiragana_msg);
    cv::waitKey(20);
  }
};



int main(int argc, char** argv){
  ros::init(argc, argv, "cultural_festival");
  LearningObject LO;
  ros::spin();
  return 0;
  }
