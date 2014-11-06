#!/usr/bin/env roseus

(ros::load-ros-manifest "cultural_festival")
(ros::roseus "character_subscriber")
(ros::roseus-add-msgs "std_msgs")

(require :nao-interface "~/ros/groovy/science_agora/euslisp/nao-interface-kochigami.l")

(setq *nao* (nao))
(setq *ni* (instance nao-interface :init))
(setq *name_learn* 0)
(setq *tenki_data* nil)
(setq *comefrom_data* nil)
(setq *food_data* nil)
(setq *subject_data* nil)
(setq *image_data* nil)
(setq *tenki-list* nil)
(setq *comefrom-list* nil)
(setq *food-list* nil)
(setq *subject-list* nil)
(setq *image-list* nil)

(setq *start-position* #f(80.7701 11.1598 -46.4971 -59.764 7.46839 82.2691 -10.3736 45.965 59.5051 -6.94585 -14.3239 -4.48007 -39.6368 121.039 -67.9785 4.30665 -14.3239 4.48488 -39.9931 121.039 -67.97 -4.34702 0.788627 3.0738))

;;名前を聞いて                                                                 
(setq name_interview #f(82.0885 11.6872 -50.8917 -61.0823 6.32579 84.2027 -10.6373 50.0959 60.1203 -5.45169 -15.115 -4.74374 -40.4278 121.039 -67.9785 4.30665 -15.115 4.13332 -40.6963 121.039 -67.97 -4.34702 1.49175 2.45857))

(setq name_interview2 #f(82.0885 11.6872 -50.8917 -61.0823 6.32579 84.2027 -10.6373 50.0959 60.1203 -5.45169 -15.115 -4.74374 -40.4278 121.039 -67.9785 4.30665 -15.115 4.13332 -40.6963 121.039 -67.97 -4.34702 1.49175 2.45857))

;;好きなものを聞いて                                                           
(setq favorite_interview #f(82.0885 11.6872 -50.8917 -61.0823 6.32579 84.2027 -10.6373 50.0959 60.1203 -5.45169 -15.115 -4.74374 -40.4278 121.039 -67.9785 4.30665 -15.115 4.13332 -40.6963 121.039 -67.97 -4.34702 1.49175 2.45857))

;;言葉を繰り返すところ
(setq kurikaesi #f(84.3737 -5.10013 -66.8001 -60.0277 62.3128 86.4879 -6.68218 61.346 60.6477 -9.6705 -14.7634 -6.32579 -50.0959 121.039 -67.9785 4.30665 -14.7634 4.83644 -50.1007 121.039 -67.97 -4.34702 -2.90283 -0.529749))

(setq kurikaesi2 #f(39.1094 -4.92435 -61.9661 -61.7855 -16.9655 33.6649 -0.969218 51.8537 63.7239 40.252 -14.7634 -5.79845 -47.547 121.039 -67.9785 4.30665 -14.7634 4.57277 -47.7276 121.039 -67.97 -4.34702 -3.25439 -1.93602))

(setq kurikaesi3 #f(85.692 -5.45169 -63.1087 -64.4222 -16.0866 82.0933 -1.40867 51.6779 62.9329 15.9939 -14.6755 -5.88634 -49.0412 121.039 -67.9785 4.29809 -14.6755 4.66066 -49.046 121.039 -67.97 -4.34702 -10.5494 -1.93602))

;;first-pose
(setq *first-pose* #f(87.2741 -11.0768 -64.6907 -59.5003 63.4554 88.9488 -1.93602 59.1487 60.6477 -11.7799 -14.5876 -5.18321 -44.0313 121.039 -67.9785 4.29809 -14.5876 3.78175 -44.124 121.039 -67.97 -4.34702 -2.90283 -3.69386))

;;おっけー

(setq ok_card #f(49.7443 -5.45169 -73.1283 -61.8734 59.1487 86.4 -6.68218 60.2034 60.5598 -10.6373 -14.9392 -5.44688 -45.8771 121.039 -67.9785 4.30665 -14.9392 3.95753 -45.9698 121.039 -67.97 -4.34702 -4.74855 -3.07861))

(setq ok_card2 #f(13.0935 -4.92435 -82.0054 -62.0492 59.1487 86.4 -6.68218 60.2034 60.4719 -10.6373 -14.8513 -5.44688 -45.8771 121.039 -67.9785 4.30665 -14.8513 3.95753 -45.9698 121.039 -67.97 -4.34702 -4.74855 -3.07861))

(setq ok_card3 #f(-1.84813 -5.3638 -82.7964 -61.7855 59.0608 86.4 -6.68218 60.2034 60.4719 -10.6373 -14.8513 -5.44688 -46.9318 121.039 -67.9785 4.30665 -14.8513 3.95753 -46.8487 121.039 -67.97 -4.34702 0.524941 -1.93602))

;;カシャ
(setq kasya #f(-3.43018 -10.3736 -50.8917 -64.0707 31.5507 38.0595 2.37068 32.166 68.2943 99.7547 -14.7634 -5.79845 -47.2834 121.039 -67.9785 4.57277 -14.7634 3.95753 -47.0245 121.039 -67.97 -4.56796 -3.60597 -1.93602))

;;repetition
(setq repetition_pose1 #f(82.6158 -3.60597 -66.097 -59.6761 63.016 51.5948 -6.59429 60.9066 61.9661 -11.5162 -14.9392 -5.44688 -45.2618 121.039 -67.9785 4.30665 -14.9392 4.13332 -45.6182 121.039 -67.97 -4.34702 -14.6803 -0.353968))

(setq repetition_pose2 #f(47.0197 -6.68218 -61.6145 -61.9613 19.7732 41.8389 1.0523 57.9182 62.4934 -10.6373 -15.0271 -4.91954 -40.252 121.039 -67.9785 4.30665 -15.0271 3.86964 -40.3447 121.039 -67.97 -4.34702 -1.84813 -3.69386))

(setq repetition_pose3 #f(85.7799 -3.78175 -60.8235 -59.6761 19.6853 73.392 0.524941 75.0571 61.9661 -21.2722 -15.0271 -4.91954 -42.0977 121.039 -67.9785 4.30665 -15.0271 3.95753 -42.3662 121.039 -67.97 -4.34702 10.193 -0.705531))

(setq repetition_pose4 #f(24.1678 -5.89115 -77.435 -61.7855 17.1365 86.1363 -5.62747 58.9729 60.5598 -50.2765 -15.0271 -5.00743 -42.6251 121.039 -67.9785 4.30665 -15.0271 4.04543 -42.9815 121.039 -67.97 -4.34702 -2.28759 -1.32078))


(defun nao-calling(mono-list)
  (dolist (japanese-char mono-list) 
    (progn             
      (if (string= japanese-char "あ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/a.wav"))
      (if (string= japanese-char "い")
	  (send *ni* :play-soundfile "/home/nao/wav_test/i.wav"))
      (if (string= japanese-char "う")
	  (send *ni* :play-soundfile "/home/nao/wav_test/u.wav"))
      (if (string= japanese-char "え")
	  (send *ni* :play-soundfile "/home/nao/wav_test/e.wav"))
      (if (string= japanese-char "お")
	  (send *ni* :play-soundfile "/home/nao/wav_test/o.wav"))
      (if (string= japanese-char "か")
	  (send *ni* :play-soundfile "/home/nao/wav_test/ka.wav"))
      (if (string= japanese-char "き")
	  (send *ni* :play-soundfile "/home/nao/wav_test/ki.wav")
	)
      (if (string= japanese-char "く")
	  (send *ni* :play-soundfile "/home/nao/wav_test/ku.wav")
	)
      (if (string= japanese-char "け")
	  (send *ni* :play-soundfile "/home/nao/wav_test/ke.wav")
	)
      (if (string= japanese-char "こ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/ko.wav")
	)
      (if (string= japanese-char "さ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/sa.wav")
	)
      (if (string= japanese-char "し")
	  (send *ni* :play-soundfile "/home/nao/wav_test/si.wav"))
      
      (if (string= japanese-char "す")
	  (send *ni* :play-soundfile "/home/nao/wav_test/su.wav")
	)
      (if (string= japanese-char "せ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/se.wav")
	)
      (if (string= japanese-char "そ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/so.wav")
	)
      (if (string= japanese-char "た")
	  (send *ni* :play-soundfile "/home/nao/wav_test/ta.wav")
	)
      (if (string= japanese-char "ち")
	  (send *ni* :play-soundfile "/home/nao/wav_test/ti.wav")
	)
      (if (string= japanese-char "つ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/tu.wav")
	)
      (if (string= japanese-char "て")
	  (send *ni* :play-soundfile "/home/nao/wav_test/te.wav")
	)
      (if (string= japanese-char "と")
	  (send *ni* :play-soundfile "/home/nao/wav_test/to.wav")
	)
      (if (string= japanese-char "な")
	  (send *ni* :play-soundfile "/home/nao/wav_test/na.wav")
	)
      (if (string= japanese-char "に")
	  (send *ni* :play-soundfile "/home/nao/wav_test/ni.wav")
	)
      (if (string= japanese-char "ぬ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/nu.wav")
	)
      (if (string= japanese-char "ね")
	  (send *ni* :play-soundfile "/home/nao/wav_test/ne.wav"))
      (if (string= japanese-char "の")
	  (send *ni* :play-soundfile "/home/nao/wav_test/no.wav")
	)
      (if (string= japanese-char "は")
	  (send *ni* :play-soundfile "/home/nao/wav_test/ha.wav")
	)
      (if (string= japanese-char "ひ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/hi.wav")
	)
      (if (string= japanese-char "ふ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/hu.wav")
	)
      (if (string= japanese-char "へ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/he.wav")
	)
      (if (string= japanese-char "ほ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/ho.wav")
	)
      (if (string= japanese-char "ま")
	  (send *ni* :play-soundfile "/home/nao/wav_test/ma.wav")
	)
      (if (string= japanese-char "み")
	  (send *ni* :play-soundfile "/home/nao/wav_test/mi.wav")
	)
      (if (string= japanese-char "む")
	  (send *ni* :play-soundfile "/home/nao/wav_test/mu.wav"))
      (if (string= japanese-char "め")
	  (send *ni* :play-soundfile "/home/nao/wav_test/me.wav")
	)
      (if (string= japanese-char "も")
	  (send *ni* :play-soundfile "/home/nao/wav_test/mo.wav")
	)
      (if (string= japanese-char "や")
	  (send *ni* :play-soundfile "/home/nao/wav_test/ya.wav"))
      (if (string= japanese-char "ゆ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/yu.wav")
	)
      (if (string= japanese-char "よ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/yo.wav")
	)
      (if (string= japanese-char "ら")
	  (send *ni* :play-soundfile "/home/nao/wav_test/ra.wav"))
      (if (string= japanese-char "り")
	  (send *ni* :play-soundfile "/home/nao/wav_test/ri.wav")
	)
      (if (string= japanese-char "る")
	  (send *ni* :play-soundfile "/home/nao/wav_test/ru.wav")
	)
      (if (string= japanese-char "れ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/re.wav"))
      (if (string= japanese-char "ろ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/ro.wav")
	)
      (if (string= japanese-char "わ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/wa.wav")
	)
      (if (string= japanese-char "を")
	  (send *ni* :play-soundfile "/home/nao/wav_test/wo.wav"))
      (if (string= japanese-char "ん")
	  (send *ni* :play-soundfile "/home/nao/wav_test/n.wav"))
      ;;added 音声ファイル直す
      
      (if (string= japanese-char "が")
	  (send *ni* :play-soundfile "/home/nao/wav_test/ga.wav")
	)
      (if (string= japanese-char "ぎ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/gi.wav"))
      (if (string= japanese-char "ぐ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/gu.wav")
	)
      (if (string= japanese-char "げ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/ge.wav")
	)
      (if (string= japanese-char "ご")
	  (send *ni* :play-soundfile "/home/nao/wav_test/go.wav"))
      (if (string= japanese-char "ざ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/za.wav")
	)
      (if (string= japanese-char "じ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/zi.wav")
	)
      (if (string= japanese-char "ず")
	  (send *ni* :play-soundfile "/home/nao/wav_test/zu.wav"))
      (if (string= japanese-char "ぜ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/ze.wav")
	)
      (if (string= japanese-char "ぞ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/zo.wav")
	)
      (if (string= japanese-char "だ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/da.wav"))
      (if (string= japanese-char "ぢ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/di.wav"))
      (if (string= japanese-char "づ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/du.wav")
	)
      (if (string= japanese-char "で")
	  (send *ni* :play-soundfile "/home/nao/wav_test/de.wav"))
      (if (string= japanese-char "ど")
	  (send *ni* :play-soundfile "/home/nao/wav_test/do.wav")
	)
      (if (string= japanese-char "ば")
	  (send *ni* :play-soundfile "/home/nao/wav_test/ba.wav")
	)
      (if (string= japanese-char "び")
	  (send *ni* :play-soundfile "/home/nao/wav_test/bi.wav"))
      (if (string= japanese-char "ぶ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/bu.wav")
	)
      (if (string= japanese-char "べ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/be.wav")
	)
      (if (string= japanese-char "ぼ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/bo.wav"))
      (if (string= japanese-char "ぱ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/pa.wav")
	)
      (if (string= japanese-char "ぴ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/pi.wav")
	)
      (if (string= japanese-char "ぷ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/pu.wav"))
      (if (string= japanese-char "ぺ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/pe.wav"))
      (if (string= japanese-char "ぽ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/po.wav")
	)
      (if (string= japanese-char "ゃ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/xya.wav"))
      (if (string= japanese-char "ゅ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/xyu.wav")
	)
      (if (string= japanese-char "ょ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/xyo.wav")
	)
      (if (string= japanese-char "っ")
	  (send *ni* :play-soundfile "/home/nao/wav_test/xtu.wav"))
      (if (string= japanese-char "　")
	  (unix:sleep 6)
	)
      )
    )
  )



(defclass making_newspaper_about_you_class
  :super propertied-object
  :slots (*tenki_data* *comefrom_data* *food_data* *subject_data* *image_data*))

(defmethod making_newspaper_about_you_class
  (:init ()
	 (ros::subscribe "nao_learn_word" std_msgs::string #'send self :character-cb)
	 )
  ;; character-cb -> name-cb -> picture-cb

  (:character-cb (msg)
		 (let ((rand_num 0)
		       (rand_num2 0))
		   ;;別に"り"じゃなくて、"登録おわり"的な写真を用意する	 
		   (if (string= (send msg :data) "おしまい")
		       (if (= *name_learn* 4)
			   (progn
			     (nao-calling *image-list*)
			     (send *ni* :angle-vector-sequence (list *first-pose* kurikaesi kurikaesi2 kurikaesi3 *first-pose*) (list 500 1000 1500 2000 2500))
			     (setq *image-list* nil)
			     ;;(print '友達ができたよ。名前は)
			     ;;(print *okashi_data*)
			     ;;(print 'っていうんだよ。)
			     ;;(print '好きなものは)
			     ;;(print *animal_data*)
			     ;;(print 'だよ。よろしくね。)
			     (setq msg (instance std_msgs::string :init))
			     (setq msg2 (instance std_msgs::string :init))
			     (setq msg3 (instance std_msgs::string :init))
			     (setq msg4 (instance std_msgs::string :init))
			     (setq msg5 (instance std_msgs::string :init))
			     (setq msg6 (instance std_msgs::string :init)) 

			     (send msg :data "写真をとる")
			     (send msg2 :data *tenki_data*)
			     (send msg3 :data *comefrom_data*)
			     (send msg4 :data *food_data*)
			     (send msg5 :data *subject_data*)
			     (send msg6 :data *image_data*)
			   
			     ;;added 
			     (if (or (substringp *food_data* "せんべい")
				     (substringp *food_data* "おせんべい"))
				 (progn
				   (setq nao-food-msg (instance std_msgs::string :init))
				   (send nao-food-msg :data "せんべいが好き")
				   (ros::publish "/nao_secret_mode_name" nao-food-msg)
				   )
			       )
			     
			     (if (substringp  *subject_data* "さんすう")
				 (progn
				   (setq nao-favorite-msg (instance std_msgs::string :init))
				   (send nao-favorite-msg :data "さんすうがとくい")
				   (ros::publish "/nao_secret_mode_favorite" nao-favorite-msg)
				   )
			       )
			     
			     ;; (if (substringp  *subject_data* "りか")
			     ;; 	 (progn
			     ;; 	   (setq nao-favorite-msg (instance std_msgs::string :init))
			     ;; 	   (send nao-favorite-msg :data "りかがとくい")
			     ;; 	   (ros::publish "/nao_secret_mode_subject" nao-favorite-msg)
			     ;; 	   )
			     ;;   )

			     ;;added end
			     
			     (unix:sleep 1)
			     (send *ni* :play-soundfile "/home/nao/wav_test/arigatou_teretyau.wav")
			     (send *ni* :play-soundfile "/home/nao/wav_test/minna_nao_to_otomodachi_ni_nattekureru.wav")
			     (send *ni* :angle-vector-sequence (list favorite_interview  *start-position*) (list 2000 3000))
			     (unix:sleep 15) ;;要変更 ;;20
			     (send *ni* :play-soundfile "/home/nao/wav_test/kinen_ni_syasin_wo_toruyo.wav")
			     ;;test
			     ;;(send *ni* :angle-vector-sequence (list *first-pose* kasya *first-pose*) (list 500 2000 2500))
			     ;;test end

			     (send *ni* :play-soundfile "/home/nao/wav_test/jyuu_byou_kazoeruyo.wav")
			     
			     (unix:sleep 4) ;;要調整
		
			     (send *ni* :play-soundfile "/home/nao/wav_test/jyuu.wav")
			     (send *ni* :play-soundfile "/home/nao/wav_test/kyuu.wav")
			     (send *ni* :play-soundfile "/home/nao/wav_test/hachi.wav")
			     (send *ni* :play-soundfile "/home/nao/wav_test/nana.wav")
			     (send *ni* :play-soundfile "/home/nao/wav_test/roku.wav")
			     (send *ni* :play-soundfile "/home/nao/wav_test/go.wav")
			     (send *ni* :play-soundfile "/home/nao/wav_test/yon.wav")
			     (send *ni* :play-soundfile "/home/nao/wav_test/san.wav")
			     (send *ni* :play-soundfile "/home/nao/wav_test/ni.wav")
			     (send *ni* :play-soundfile "/home/nao/wav_test/ichi.wav")
			     (send *ni* :play-soundfile "/home/nao/wav_test/kasya.wav")
			     (unix:sleep 20) ;;この配分をしらべる
			     (send *ni* :angle-vector-sequence (list *first-pose* kasya *first-pose*) (list 500 2000 2500)) ;;この配分をしらべる
			     (unix:sleep 2)
			     (ros::publish "/nao_friend_tenki" msg2)
			     (ros::publish "/nao_friend_comefrom" msg3)
			     (ros::publish "/nao_friend_food" msg4)
			     (ros::publish "/nao_friend_subject" msg5)
			     (ros::publish "/nao_friend_image" msg6)
			     (ros::publish "/nao_taking_picture_permission" msg)
			   
			     
			     (ros::ros-info "take a photo")
			     (setq *tenki_data* nil)
			     (setq *comefrom_data* nil)
			     (setq *food_data* nil)
			     (setq *subject_data* nil)
			     (setq *image_data* nil)
			     (setq *name_learn* 0)
			     )
			 (progn
			   (setq *name_learn* (+ *name_learn* 1))
			   ;;ちょっと待つ
			   (unix:sleep 2)

			   ;;名前を呼ぶ機能をつけたい
			   ;;added 
			   ;;*name_learn*==1 なら天気
			   (if (= *name_learn* 1)
			       (progn
				 ;;test
				 (send *ni* :angle-vector-sequence (list *first-pose* ok_card ok_card2 ok_card3 *first-pose*) (list 500 1000 1500 2000 2500))
				 
				 ;;test end
				 (nao-calling *tenki-list*)
				 (setq *tenki-list* nil)
				 (send *ni* :play-soundfile "/home/nao/wav_test/dane.wav")
				 ;;added end
				 (if  (substringp  "はれ" *tenki_data*)
				     (progn
				       (send *ni* :play-soundfile "/home/nao/wav_test/nao_ha_hare_ga_daisuki.wav")
				       )
				   (if  (substringp  "あめ" *tenki_data*)
				       (progn
					 (send *ni* :play-soundfile "/home/nao/wav_test/nao_ha_okiniiri_no_raincoat.wav")
				     
					 )
				     (progn
				       ;;(send *ni* :play-soundfile "/home/nao/wav_test/nanda.wav")
				       (send *ni* :play-soundfile "/home/nao/wav_test/nao_ha_hare_ga_daisuki_dayo.wav")
				       )
				     )
				   )
				     
				 (send *ni* :angle-vector-sequence (list name_interview name_interview2 *start-position*) (list 2500 3500 4500))
				 (unix:sleep 2)
				 (send *ni* :play-soundfile "/home/nao/wav_test/tsugi_no_hito_douzo.wav")
				 (send *ni* :play-soundfile "/home/nao/wav_test/kyou_ha_dokokara_kitano.wav")
				 
				 )
			     )
			   (if (= *name_learn* 2) ;;どこから来たのか
			       (progn
				 (send *ni* :angle-vector-sequence (list *first-pose* repetition_pose1 *first-pose*) (list 500 800 1100))
				 (nao-calling *comefrom-list*)
				 (setq *comefrom-list* nil)
				 (send *ni* :play-soundfile "/home/nao/wav_test/umare_ha_france.wav")
				 (unix:sleep 7)
				 ;;ちょっとビックリしたでしょの動き
				 (send *ni* :play-soundfile "/home/nao/wav_test/tyotto_bikkuri_sitadesyo.wav")
				 ;;動き・次の質問を変える (食べ物）
				 (send *ni* :angle-vector-sequence (list name_interview name_interview2 *start-position*) (list 2500 3500 4500))
				 (unix:sleep 2)
				 (send *ni* :play-soundfile "/home/nao/wav_test/tsugi_no_hito_douzo.wav")
				 (send *ni* :play-soundfile "/home/nao/wav_test/sukina_tabemono_ha_naani.wav")
				 )
			     )
			   (if (= *name_learn* 3) ;;食べ物
			       (progn
				 (send *ni* :angle-vector-sequence (list *first-pose* repetition_pose2 *first-pose*) (list 500 800 1100))
				 ;;(nao-calling *food-list*)
				 (nao-calling *food-list*)
				 (setq *food-list* nil)
				 (if  (or (substringp "おせんべい" *food_data*)
					  (substringp "せんべい" *food_data*))
				     
				     (progn
				       ;;(setq *food-list* nil)
				       (send *ni* :play-soundfile "/home/nao/wav_test/wao_osenbei.wav")
				       )
				   (progn
				     (send *ni* :play-soundfile "/home/nao/wav_test/naruhodo.wav")
				     ;;(nao-calling *food-list*)
				     ;;(setq *food-list* nil)
				     (send *ni* :play-soundfile "/home/nao/wav_test/nao_ha_osenbei_ga_daisuki.wav")

				     )
				   )
				 ;;動き・次の質問を変える (得意科目）
				 (send *ni* :angle-vector-sequence (list name_interview name_interview2 *start-position*) (list 2500 3500 4500))
				 (unix:sleep 2)
				 (send *ni* :play-soundfile "/home/nao/wav_test/tsugi_no_sitsumon_dayo.wav")
				 (send *ni* :play-soundfile "/home/nao/wav_test/ichiban_tokui_na_kamokuha_naani.wav")
				 )
			     )
			   (if (= *name_learn* 4) ;;得意科目
			       (progn
				 (send *ni* :angle-vector-sequence (list *first-pose* repetition_pose3 *first-pose*) (list 500 800 1100))
				 (nao-calling *subject-list*)
				 (setq *subject-list* nil)
				 (if (substringp "さんすう" *subject_data*)
				     (progn
				       (send *ni* :play-soundfile "/home/nao/wav_test/sansuu_nao_ha_nigate.wav")
				       )
				   (progn
				     ;;(nao-calling *subject-list*)
				     ;;(setq *subject-list* nil)
				     (send *ni* :play-soundfile "/home/nao/wav_test/rika_nao_ha_suki.wav")
				     )
				   )
				 ;;動き・次の質問を変える (ナオの印象）
				 (send *ni* :angle-vector-sequence (list name_interview name_interview2 *start-position*) (list 2500 3500 4500))
				 (unix:sleep 2)
				 (send *ni* :play-soundfile "/home/nao/wav_test/korega_saigo_no_sitsumon_dayo.wav")
				 (send *ni* :play-soundfile "/home/nao/wav_test/nao_no_koto_dou_omou.wav")
				 )
			     )
			   
			   )
			 )
		     (progn
		       (if (= *name_learn* 0)
			   ;;added
			   (progn
			     (setq *tenki_data* (concatenate string *tenki_data* (send msg :data)))           
			     ;;added 
			     (setq *tenki-list* (append *tenki-list* (list (send msg :data))))
			     ;;added end 
			     )
			 )
		       (if (= *name_learn* 1)
			   ;;added
			   (progn
			     (setq *comefrom_data* (concatenate string *comefrom_data* (send msg :data)))
			     (setq *comefrom-list* (append *comefrom-list* (list (send msg :data))))
			     )
			 )
		       (if (= *name_learn* 2)
			   ;;added
			   (progn
			     (setq *food_data* (concatenate string *food_data* (send msg :data)))
			     (setq *food-list* (append *food-list* (list (send msg :data))))
			     )
			 )
		       (if (= *name_learn* 3)
			   ;;added
			   (progn
			     (setq *subject_data* (concatenate string *subject_data* (send msg :data)))
			     (setq *subject-list* (append *subject-list* (list (send msg :data))))
			     )
			 )
		       (if (= *name_learn* 4)
			   ;;added
			   (progn
			     (setq *image_data* (concatenate string *image_data* (send msg :data)))
			     (setq *image-list* (append *image-list* (list (send msg :data))))
			     )
			 )
		       
		       )
		     )
		   )
		 )
  )

(setq m (instance making_newspaper_about_you_class :init))

(ros::advertise "/nao_taking_picture_permission" std_msgs::string 1)
(ros::advertise "/nao_friend_tenki" std_msgs::string 1)
(ros::advertise "/nao_friend_comefrom" std_msgs::string 1)
(ros::advertise "/nao_friend_food" std_msgs::string 1)
(ros::advertise "/nao_friend_subject" std_msgs::string 1)
(ros::advertise "/nao_friend_image" std_msgs::string 1)
(ros::advertise "/nao_secret_mode_name" std_msgs::string 1)
(ros::advertise "/nao_secret_mode_favorite" std_msgs::string 1)
(ros::advertise "/nao_secret_mode_subject" std_msgs::string 1)

(ros::ros-info "start subscribing")
(while (ros::ok)
  (ros::spin-once)
  )