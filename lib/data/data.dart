//import 'package:flutter/material.dart';


class SliderModel{

  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath,this.title,this.desc});

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}


List<SliderModel> getSlides(){

  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("Call your loved ones from the random contacts you get everyday. A reminder to connect with friends");
  sliderModel.setTitle("Contact");
  sliderModel.setImageAssetPath("images/page13.jpg");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("Change the number of contacts to appear in the settings page. Selecting a number will automatically update your contacts.s");
  sliderModel.setTitle("Settings");
  sliderModel.setImageAssetPath("images/page2.jpg");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}