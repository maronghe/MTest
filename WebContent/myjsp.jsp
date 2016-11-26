<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<script src="js/jquery.js"></script>
<link rel="stylesheet" href="player.css">
</head>
<body>
	<form action="readfile" method="post" enctype="multipart/form-data">
		<input type="file" id="uploadedFile" name="filename" multiple></input>
		<input type="submit" value="播放">
	</form>
	<br />
	<div id="check"></div>
	<div class="m_player mini_version" id="divplayer" role="application"
		style="z-index: 100000; left: 0px;">
		<div class="m_player_dock" id="divsongframe">
			<div class="music_info" id="divsonginfo">
				<a target="contentFrame" class="album_pic" title=""> <img
					src="http://i.gtimg.cn/mediastyle/y/img/cover_mine_130.jpg" alt=""
					onerror="this.src='http://imgcache.qq.com/mediastyle/y/img/cover_mine_130.jpg'">
				</a>
				<div class="music_info_main">
					<p class="music_name" title="听我想听的歌！">
						<span id="musicName">听我想听的歌！</span> <a
							onclick="g_topPlayer.singleFm.open();" href="javascript:;"
							class="icon_radio">电台</a>
					</p>
					<p class="singer_name" title="QQ音乐" id="playerName">QQ音乐</p>
					<p class="play_date" id="ptime"></p>
					<p class="music_op" style="display: none;">
						<strong class="btn_like_n" title="暂不提供此歌曲服务"
							onclick="MUSIC.event.cancelBubble();" name="myfav_undefined"
							mid=""> <span>我喜欢</span>
						</strong> <strong class="btn_share_n" title="暂不提供此歌曲服务"
							onclick="MUSIC.event.cancelBubble();"> <span>分享</span>
						</strong> <strong class="btn_kge"
							onmouseover="this.className='btn_kge btn_kge_hover';this.style.zIndex='100';"
							onmouseout="this.className='btn_kge';this.style.zIndex='';"
							style="display: none;" id="btnkge"> </strong>
					</p>
				</div>
			</div>
			<div class="bar_op">
				<strong title="上一首( [ )" class="prev_bt"
					onclick="g_topPlayer.prev();" id="nextone"><span>上一首</span></strong>
				<strong title="播放(P)" class="play_bt" id="btnplay"
					onclick="g_topPlayer.play();"><span>播放</span></strong> <strong
					title="下一首( ] )" class="next_bt" onclick="g_topPlayer.next();"
					id="preone"><span>下一首</span></strong> <strong title="随机播放"
					class="unordered_bt" id="btnPlayway"
					onclick="g_topPlayer.setPlayWay();"><span>随机播放</span></strong>
				<p class="volume" title="音量调节">
					<span class="volume_icon" id="spanmute" title="点击设为静音(M)"></span> <span
						class="volume_regulate" id="spanvolume"> <span
						class="volume_bar" style="width: 100%;" id="spanvolumebar"></span>
						<span class="volume_op" style="left: 100%;" id="spanvolumeop"></span>
					</span>
				</p>
			</div>
			<p class="playbar_cp_select" id="divselect" style="display: none;">
				<strong title="顺序播放" class="ordered_bt" onclick="realSetPlayWay(0);">
					<span>顺序播放</span>
				</strong> <strong title="随机播放" class="unordered_bt"
					onclick="realSetPlayWay(1);"> <span>随机播放</span>
				</strong> <strong title="单曲循环" class="cycle_single_bt"
					onclick="realSetPlayWay(2);"> <span>单曲循环</span>
				</strong> <strong title="列表循环" class="cycle_bt" onclick="realSetPlayWay(3);">
					<span>列表循环</span>
				</strong>
			</p>
			<p class="player_bar" id="player_bar">
				<span class="player_bg_bar" id="spanplayer_bgbar"></span> <span
					class="download_bar" id="downloadbar" style="width: 0%;"></span> <span
					class="play_current_bar" style="width: 0%;" id="spanplaybar"></span>
				<span class="progress_op" style="left: 0%;" id="spanprogress_op"></span>
			</p>
			<div class="time_show"
				style="left: 240px; bottom: 8px; display: none;">
				<p id="time_show"></p>
				<span class="icon_arrow_foot"><i class="foot_border"></i><i
					class="foot_arrow"></i></span>
			</div>
		</div>
		<span class="active_tip" id="spanaddtips"
			style="top: 0px; display: none;"></span> <span title="展开播放列表"
			class="open_list" id="spansongnum1" style="display: block;"><span>0</span></span>
		<span title="显示歌词(L)" class="btn_lyrics_disabled" id="btnlrc">歌词(L)</span>
		<button type="button" class="folded_bt" title="点击收起" id="btnfold">
			<span>点击收起/展开</span>
		</button>
		<!--play list-->
		<div class="y_player_lyrics" id="player_lyrics_pannel"
			style="display: none;">
			<div class="lyrics_text" id="qrc_ctn"></div>
			<div class="lyrics_bg"></div>
			<span class="close_lyrics" id="closelrcpannel"></span>
		</div>
		<div class="play_list_frame" id="divplayframe"
			style="display: none; opacity: 1;">
			<div class="play_list_title">
				<!-- 单曲FM修改 -->
				<ul id="tab_container" style="width: 270px;">
					<li id="playlist_tab" class="current"><a href="javascript:;"
						title="播放列表">播放列表</a><i></i></li>
					<li id="fm_tab" style="display: none"><a href="javascript:;"
						title="单曲电台列表">单曲电台列表</a><i></i></li>
				</ul>
				<span id="clear_list" class="clear_list"
					onclick="g_topPlayer.clearList();">清空列表</span> <strong
					title="收起播放列表" class="close_list" id="btnclose"></strong>
			</div>
			<div class="play_list" id="divlistmain">
				<!--列表为空提示_S-->
				<div class="play_list_point" id="divnulllist"
					style="display: block;">您当前还未添加任何歌曲</div>
				<!--列表为空提示_E-->
				<div class="play_list_main" id="divplaylist" style="display: none;">
					<!-- 播放列表_S-->
					<div class="single_list" id="divsonglist" dirid="0">
						<ul></ul>
					</div>
					<div id="divalbumlist" style="display: none;"></div>
				</div>
			</div>
			<!--歌词内容-->
			<div class="single_radio_tip" id="single_radio_tip"
				style="display: none;">
				<a href="javascript:;" class="close_tips" title="关闭"></a>
			</div>
		</div>
</body>



<script type="text/javascript">
var playstyle = 0;//播放方式，0-顺序，1随机，2单曲，3列表
var audioBufferSouceNode = null; //播放声音，声源
var file = null; // the current file
var fileName = null;
var audioContext = null; //音频内容
var source = null;// the audio source 
var infoUpdateId = null;
var animationId = null;//动画
var gainNode = null;//增加节点
var status = 0; // 1 playing ,0 stopped
var allCapsReachBottom = false;
var analyser = null;//分析器
var loud = 1;
var loca = 0;
var cli = false;
var pli = false;
var length;
var l;
var buf = null;
var playerName;
var musicName;
var req;
var fileLength;
var audioInput =  document.getElementById("uploadedFile");
var playNumber = 0;
if(window.XMLHttpRequest){
	req = new XMLHttpRequest();
}else if(window.ActiveXObject){
	try {
		req = new ActiveXObject("Msxm12.XMLHTTP");
	} catch (e) {
		req = new ActiveXObject("Microsoft.XMLHTTP");
	}
}
$("#btnPlayway").click(function() {
	$("#divselect").fadeToggle();
})
$("#spansongnum1").click(function() {
	$("#divplayframe").fadeToggle();
})
$("#btnclose").click(function() {
	$("#divplayframe").fadeToggle();
})
$("#btnlrc").click(function() {
	$("#player_lyrics_pannel").fadeToggle();
})
$("#closelrcpannel").click(function() {
	$("#player_lyrics_pannel").fadeToggle();
})
$("spanvolume").mousedowm(function(e){
	cli = true;
})
$("spanvolume").mouseup(function(e){
	cli = false;
})
$("#spanvolume").mousemove(function(e) {
	if(cli == true){
		var n = (e.pageX - 455) / 75;
		if(n > 1){
			n = 1;
		}
		$("#spanvolumebar")[0].style.width = n * 100 + "%";
		$("#spanvolumeop")[0].style.left = n * 100 + "%";
		gainNode.gain.value = n - 1;
	}
})
$("#spanvolume").click(function(e) {
	var n = (e.pageX - 445) / 76;
	$("#spanvolumebar")[0].style.width = n * 100 + "%";
	$("#spanvolumeop")[0].style.left = n * 100 + "%";
	gainNode.gain.value = n - 1;
})
function loadAudioFile(url){
	alert(url);
	var xhr = new XMLHttpRequest(); //通过xhr 下载音频文件
	xhr.open("GET", url, true);
	xhr.responseType = "arraybuffer";
	xhr.onload = function(e){
		initSound(this.responese);
	};
	xhr.send();
}
function initSound(arraybuffer){
	audioContext.decodeAudioData(arraybuffer,function(buffer){
		buf = buffer;
		visualize(audioContext , buf , 0);
	},function(){
		alert("no");
	} )
}
//音量
$("player_bar").mousedown(function(e){
	audioBufferSouceNode.stop();
	pli = true ;
})
$("player_bar").mouseup(function(e){
	pli = false;
	audioBufferSouceNode.stop();
	visualize(audioContext,buf,loca/1000);
})
$("player_bar").mouseleave(function(e){
	if (pli == true) {
		audioBufferSouceNode.stop();
		visualize(audioContext,buf,loca/1000);
	}
	pli = false;
})
$("#player_bar").mousemove(function(e) {
	if (pli == true) {
		var n = (e.pageX) / 538;
		if (n > 1)
			n = 1;
		loca = parseInt(length * n * 1000);
		$("#spanplaybar")[0].style.width = n * 100 + "%";
		$("#spanprogress_op")[0].style.left = n * 100 + "%";
		audioBufferSouceNode.stop();
	}
})
$("preone").click(function(e){
	if(playNumber + 1 < fileLength){
		audioBufferSouceNode.stop();
		loca = 0;
		playNumber++;
		dofile(playNumber);
	}
})
$("nextone").click(function(e){
	if (playNumber - 1 >= 0) {
		clearInterval(1);
		audioBufferSouceNode.stop();
		loca = 0;
		playNumber--;
		dofile(playNumber);
	}
})
$("#player_bar").click(function(e) {
	var n = (e.pageX) / 538;
	loca = parseInt(length * n * 1000);
	$("#spanplaybar")[0].style.width = n * 100 + "%";
	$("#spanprogress_op")[0].style.left = n * 100 + "%";
	audioBufferSouceNode.stop();
	visualize(audioContext, buf, loca / 1000);
})
//基本功能
/*
 * 静音
 */
$("#spanmute").click(function(e){
	if(gainNode.gain.value == -1 ){
		gainNode.gain.value = loud;
	}else{
		loud = gainNode.gain.value;
		gainNode.gain.value = -1;
	}
})
/*
 * 暂停
 */
$("#btnplay").click(function() {
	if(status == 1){
		status = 0 ;
		clearInterval(1);
		audioBufferSouceNode.stop();
	}else{
		status = 1;
		l = setInterval("play()", 1000);//
		cisualize(audioContext,buf,loca/1000);
	}
	window.onload = function(){
		ini();
	};
})
/*
 * 播放方式，0-顺序，1随机，2单曲，3列表
 */
function realSetPlayWay(n){
	$("#divselect").fadeToggle();
	playstyle = n;
	if (n == 0) {
		$("#btnPlayway").attr("class", "ordered_bt");
	} else if (n == 1) {
		$("#btnPlayway").attr("class", "unordered_bt");
	} else if (n == 2) {
		$("#btnPlayway").attr("class", "cycle_single_bt");
	} else {
		$("#btnPlayway").attr("class", "cycle_bt");
	}
}

function paly(){
	loca += 1000;
	var n = (loca /1000) / length;
	if(n >= 1){
		n = 1;
		audioBufferSouceNode.stop();
	}
	var t1 = (Array(2).join('0') + parseInt(loca / 1000 / 60)).slice(-2);
	var t2 = (Array(2).join('0') + (parseInt(loca / 1000) % 60)).slice(-2);
	var s = t1 + ":" + t2;
	$("#ptime").text(s);
	$("#spanplaybar")[0].style.width = n * 100 + "%";
	$("#spanprogress_op")[0].style.left = n * 100 + "%";
}
function ini(){
	perpareAPI();
	loadAudioFile("music/a.mp3");//音乐文件路径
}
/*
 * 准备API
 */
function prepareAPI(){
	window.AudioContext = window.AudioContext || window.webkitAudioContext
	|| window.mozAudioContext || window.msAudioContext;
	window.requestAnimationFrame = window.requestAnimationFrame
	|| window.webkitRequestAnimationFrame
	|| window.mozRequestAnimationFrame
	|| window.msRequestAnimationFrame;
	window.cancelAnimationFrame = window.cancelAnimationFrame
	|| window.webkitCancelAnimationFrame
	|| window.mozCancelAnimationFrame
	|| window.msCancelAnimationFrame;
	audioContext = new AudioContext();
}
function addEventListner() {
	audioInput.onchange = function() {
		$("#divnulllist").text("");
		fileLength = audioInput.files.length;
		for (var j = 0; j < fileLength; j++) {
			var filed = audioInput.files[j];
			var fileNamed = filed.name;
			var top = fileNamed.indexOf("-", 1);
			var music = fileNamed.substring(0, top);
			var player = fileNamed.substring(top + 1, fileNamed.length - 4);
			$("#divnulllist").html(
					$("#divnulllist").html() + "<br/>" + music + "    "
							+ player);
		}
		dofile(playNumber);
	}
}

function dofile(n) {
	if (audioContext === null) {
		return;
	}
	;
	if (audioInput.files.length !== 0) {
		file = audioInput.files[n];
		fileName = file.name;
		var index = fileName.indexOf("-", 1);
		playerName = fileName.substring(0, index);
		musicName = fileName.substring(index + 1, fileName.length - 4);
		$("#musicName").text(musicName);
		$("#playerName").text(playerName);
		start(0);
	}
};

function start(n) {
	var fr = new FileReader();
	fr.onload = function(e) {
		var fileResult = e.target.result;//result储存读取结果
		if (audioContext === null)
			return;
		audioContext.decodeAudioData(fileResult, function(buffer) //解码成功
		{
			buf = buffer;
			//		ll=setInterval(getString,1000);
			l = setInterval('play();', 1000);
			visualize(audioContext, buffer, n);
		});
	};
	fr.onerror = function(e) {
		console.log(e);
	};
	fr.readAsArrayBuffer(file);
}

function visualize(audioContext, buffer, n)
function visualize(audioContext, buffer, n) {
	audioBufferSouceNode = audioContext.createBufferSource();
	analyser = audioContext.createAnalyser();
	audioBufferSouceNode.connect(analyser);
	analyser.connect(audioContext.destination);
	audioBufferSouceNode.buffer = buffer;
	volumeControl(audioContext, audioBufferSouceNode, 1);
	stopStart = audioContext.currentTime;
	length = audioBufferSouceNode.buffer.duration;
	//   getString();
	audioBufferSouceNode.start(0, n);
	status = 1;
	source = audioBufferSouceNode;
	audioBufferSouceNode.onended = function() {
		//   audioEnd();
	};
}

function volumeControl(audioContext, audioBufferSouceNode, n) {
	gainNode = audioContext.createGain();
	audioBufferSouceNode.connect(gainNode);
	gainNode.connect(audioContext.destination);
	gainNode.gain.value = n;
}

function audioEnd() //播放模式0顺序1随机2单曲3列表
{
	//	$("#check").text(loca+"  "+length*1000);
	if (loca >= length * 1000) {
		loca = 0;
		$("#ptime").text("00:00");
		$("#spanplaybar")[0].style.width = 0 + "%";
		$("#spanprogress_op")[0].style.left = 0 + "%";
		clearInterval(l);
		clearInterval(ll);
		if (playstyle == 0) {
			if (playNumber + 1 < fileLength) {
				playNumber++;
				dofile(playNumber);
			}
		} else if (playstyle == 1) {
			playNumber = parseInt(Math.random() * fileLength);
			dofile(playNumber);
		} else if (playstyle == 2) {
			dofile(playNumber);
		} else if (playstyle == 3) {
			if (playNumber + 1 < fileLength) {
				playNumber++;
				dofile(playNumber);
			} else {
				playNumber = 0;
				dofile(playNumber);
			}
		}
	}
}

</script>





</html>