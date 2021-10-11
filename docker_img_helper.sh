#!/bin/sh

# maintainer : ethan 

# begin date : 2020-09-03 

# finish : save images, push images , tag images ,load images ,delete images



# save image

img_2_tar(){
  
  str=$1 
  
  tar_name=`awk -v mystr=$str 'BEGIN{str=mystr;gsub(/["/"|":"]/,"-",str);print str}'`

  my_tar=${tar_name}.tar

  echo "------$str------"

  echo $my_tar "is saving... "

  docker save $str -o $my_tar

  echo $str "save success ."

  echo "-------------------------------------------------"

}


# save all images from local machine

imgs_2_all_tar(){

ALL_IMAGES_STR=`docker images|sed 1d|awk '{print $1":"$2}'`
   
  for str in $ALL_IMAGES_STR

    do
 
      img_2_tar $str;
   
    done
}


# save grep images from local machine

imgs_2_grep(){

GREP_STR=$1
   
GREP_IMAGE_STR=`docker images|grep $GREP_STR|awk '{print $1":"$2}'`
 
 for str in $GREP_IMAGE_STR

     do

       img_2_tar $str;

     done

}


load_images(){
  
  images=`ls|grep tar`
   
  for str in $images
    
     do
 
       docker load -i $str
     
     done
}

tag_images(){
    
   old_reg_url=$1
   
   new_reg_url=$2

   GREP_IMAGES=`docker images |grep $old_reg_url|awk '{print $1":"$2}'`

   for str in $GREP_IMAGES
    
     do

       #new_str=`awk -v mystr=$str 'BEGIN{str=mystr;gsub("$old_reg_url","$new_reg_url",str);print str}'`
   
       new_str=`echo $str |sed "s/$old_reg_url/$new_reg_url/g"`
       
       echo $new_str
       
       docker tag $str $new_str

       #docker push $new_str
  
     done
 
}


push_images(){

    grep_str=$1

    imgs_infos=`docker images |grep $grep_str|awk '{print $1":"$2}'`

    for str in $imgs_infos

    do 

    docker push $str

    done

}

delete_images(){

    grep_str=$1

    docker rmi `docker images |grep ${grep_str}|awk '{print $1":"$2}'`
}

# usage for this sh

usage(){

  echo "Usage:"
  
  echo "      sh $0 [options] ... "

  echo " "

  echo "Mandatory arguments to long options are mandatory for short options too."  
  
  echo " "

  echo "       save all                       save all local images to pwd"
  
  echo "       save [ grepstr ]               save grep images to pwd"

  echo "       tag [ oldurl ] [ newurl ]      tag grep url images to new url"

  echo "       push [ grepstr ]               push grep images to registry from local machine"

  echo "       load all                       load all tars  from current path"
 
  echo "       del [ grepstr ]                delete grep images tag  from local machine"  
  echo " "
 
  echo "EXAMPLE:"

  echo " # save reg.kolla.org images to local" 
 
  echo " " 
  echo " sh $0 save reg.kolla.org   "
  echo " "
  echo " # load  pwd images to local machine " 
  echo " "
  echo " sh $0 load all "
  echo " "
  echo " # tag local machine  images to new str" 
  echo " "
  echo " sh $0 tag reg.kolla.org test.com "
  echo " "
  echo " # push grep  images to registry" 
  echo " "

  echo " sh $0 push test.com "

  echo " "
  
  echo " # delete grep images" 
  echo " "
  echo " sh $0 del test.com "
   
  echo " "

}

main (){

  if [ -n $1 ];then

    method=$1

    grepname=$2

    case $method in

      save)
        
          if [ -n $2 ];then

              if [ $2 == "all" ];then
              
                imgs_2_all_tar;
        
              elif [ $2 != "all" ];then
               
                imgs_2_grep $2;
              
              fi
          fi 

          ;;
      
      load)


          if [ -n $2 ];then

              if [ $2 == "all" ];then

                load_images;

              elif [ $2 != "all" ];then
                 
                echo "todo"

              fi
          fi

          ;;
      tag)

          if [ -n $2 ];then

                tag_images $2 $3;

          fi

          ;;

      push)

          if [ -n $2 ];then

                push_images $2;

          fi

          ;;
   
      del)

          if [ -n $2 ];then

               delete_images $2;

          fi

          ;;

      *)

          usage;
          esac;

  fi
}

main $1 $2 $3
