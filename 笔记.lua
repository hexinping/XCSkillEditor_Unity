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