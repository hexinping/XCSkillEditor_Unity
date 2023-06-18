技能编辑器分3部分:

1.技能预览, Flux在预览部分基本都做好了,用法和TimeLine类似。

2.技能数据保存。需要将Flux中的序列事件信息保存起来，给技能执行器用。

3.技能事件执行器。核心运行逻辑。

总的来说就是，用Flux做技能预览，然后序列化技能数据，保存帧时间序列。
比如动作，特效，位移等等事件。最后是模仿Flux的序列(Sequence)做技能事件执行器。


https://www.bilibili.com/read/cv19446896?from=search

TODO
{
	1 熟悉FLux制作方式
	{
		1 默认支持方式
		2 自定义方式，可以直接看项目里扩展方式  
	}


	2 技能数据保存方式

	3 技能事件执行
}



--[==[

Flux的结构是，Sequence→Container→Timeline→Track→Event。一个父容器包含多个子容器。
比如Sequence包含多个Container。以此类推，一个Track上放多个Event。

创建流程：创建一个Sequence，在默认容器Container（Default）上， 添加玩家TimeLine，加上动画Track，再加上一段AnimationClip作为动画事件。 



2.数据保存

Event的主要结构：起始帧Start，结束帧End，以及内容。

如动画事件的内容为AnimationClip，StartOffset（动画偏移） 和 BlendLength（动画混合帧数） 


3.技能事件执行器，核心运行逻辑 

由于Container一般只用一个。所以运行时的逻辑层简化为 :

Sequence→Timeline→Track→Event。

Sequence为主技能和子技能的总和，

Timeline为单个主/子技能，

Track则对应类型EventList（如AnimEvents），

Event则是最小的事件单位。 
]==]

--[==[

Flux常用脚本调用流程和方法
{
	Flux的默认脚本可以自己扩展，需要什么字段可以自己加

	FSequence:Init ==> FContainer:Init==>FTimeline:Init ==> FTrack:Init==> FEvent:Init ()//可以重载Fevent类型的OnInit方法完成自己的初始化

	FEvent:Trigger==> FEvent开始时调用一次，每个新的FEvent都会调用 ==> Trigger方法里会调用OnTrigger, 子类可以重载
	FEvent:Finish==> FEvent结束时调用一次，每个新的FEvent都会调用 ==> Finish方法里会调用OnFinish, 子类可以重载

	暂停，恢复，停止==》 分别调用FEvent的Pause,Resume,Stop ==> 分别重载OnPause，OnResume, OnStop

	有每一帧都调用的方法吗==>FEvent运行时，UpateEvent每一帧都会调用，子类可以重载OnUpdateEvent方法
}

]==]

--[==[

自定义track 参考 ==> FTriggerRangeTrack   FTriggerRangeTrackEditor重写了面板
{
	Test_DrawCube  ==》 用来scene窗口下绘制碰撞盒的
	FTriggerRangeEvent ==> 添加event属性
}


FSwitchEvent


自定义Track步骤
{
	1 Assets/Flux/Runtime/Tracks/下添加一个Track的脚本，在命名空间Flux下，并且继承FTrack
	{
		namespace Flux
		{
		    public class FTriggerRangeTrack:FTrack
		    {
		        
		    }
		}
	}

	2 编写对应的Event脚本 Assets/Flux/Runtime/Events
	{
		namespace Flux
		{
					//碰撞器范围Track
		    [FEvent("Custom/碰撞器范围Track", typeof(FTriggerRangeTrack))]
		    public class FTriggerRangeEvent: FEvent
		    {
		        public CubeRange cubeRange;
		        public string ackId = "0";
		    }
		}

	}

	3 编写对应的编辑器脚本，如果有需求可以需要  Assets/Flux/Editor/Editors， 重写对应的方法
	{
		[FEditor(typeof(FTriggerRangeTrack))]
	    public class FTriggerRangeTrackEditor : FTrackEditor
	    {}
	}

	4 修改Event的颜色，在Assets/Flux/Editor/FluxSettings.asset文件里配置
	
}
]==]

--[==[
Flux编辑器窗口文件：FSequenceEditorWindow.cs
{
	FSequenceWindowHeader.cs   Sequence头部编辑区域脚本
	{
		FSequenceWindowHeader.cs 中的保存按钮 调用的是  SavaSequenceData.GetData();
	}
}


]==]



--[==[
技能数据保存

Assets/Scripts/Skill/ ===>自定义技能数据结构

]==]