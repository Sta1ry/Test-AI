interface JobData {
  id: number;
  title: string;
  salary: string;//工资
  company: string;//贵司信息
  require:string;//要求
  contact:string;//联系人
  location: string;//地点
}

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State currentTabIndex: number = 0; // 默认选中"推荐"标签
  @State displayedJobs: JobData[] = []; // 当前显示的职位列表
  @State showDialog: boolean = false; // 控制提示框显示状态

  // 职位卡片构建器
  @Builder
  buildJobCard(job: JobData) {
    Column({space:5}) {
      // 职位、薪资
      Row() {
        Text(job.title)
          .fontSize(16)
          .fontColor($r('sys.color.black'))
          .margin({ left:10,bottom:5,right:20,top:5 })
        Text(job.salary)
          .fontSize(16)
          .fontColor('#ff43b5c4')
          .height(10)
          .margin({right:20,bottom:5})
      }
      .backgroundColor(Color.White)
      .width('100%')

      // 公司
      Text(job.company)
        .fontSize(14)
        .fontColor('#666666')
        .margin({left:15,bottom:5})
        .backgroundColor(Color.White)
        .width('100%')
        .height(15)

      // 要求
      Text(job.require)
        .fontSize(12)
        .margin({left:5})
        .fontColor('#999999')
        .backgroundColor(Color.White)
        .width('100%')

      // 联系人、地点
      Row() {
        Image($r(`app.media.tx`))
          .width(20)
          .height(20)
          .margin({ left:5,right: 5 })
        Text(job.contact)
          .fontSize(12)
          .margin({left:15})
          .fontColor('#666666')
        Text(job.location)
          .fontSize(12)
          .fontColor('#999999')
          .margin({ left: 50 })
      }
      .backgroundColor(Color.White)
      .margin({ bottom: 2})
      .width('100%')
    }
    .margin({bottom:10})
    .borderWidth(1)
    .borderColor('#ff797676')
    .borderRadius(8)
    .width('95%')
    .height(100)
    // 添加点击事件
    .onClick(() => {
      this.showDialog = true; // 显示提示框
    })
  }

  // 自定义提示框组件
  @Builder
  customDialog() {
    // 半透明背景
    Column()
      .width('100%')
      .height('100%')
      .backgroundColor('#4dd7d5d5')
      .opacity(0.5)
      .onClick(() => {
        this.showDialog = false; // 点击背景关闭提示框
      })

    // 提示框内容
    Column() {
      Text('查看详情')
        .fontSize(20)
        .fontColor(Color.Black)
        .margin({top:50})
    }
    .width(250)
    .height(150)
    .backgroundColor(Color.White)
    .borderRadius(10)
    .shadow({ radius: 10, color: '#000000', offsetX: 0, offsetY: 0 })
  }

  tabs: string[] = ['推荐', '附近', '最新'];
  jobList: JobData[] = [
    {
      id: 1,
      title: "鸿蒙开发工程师",
      salary: "55-75K·16薪",
      company: "小红书",
      require: "3-5年，本科、软件开发、前端技术",
      contact: "李利",
      location: " 朝阳区 亚运村",

    },
    {
      id: 2,
      title: "鸿蒙开发工程师(J12447)",
      salary: "25-35K·14薪",
      company: "点点互动",
      require: "3-5年、大专、问题排查、跨平台开发",
      contact: "赵娜",
      location: "海淀区 中关村",

    },
    {
      id: 3,
      title: "居家鸿蒙工程师",
      salary: "500–1500元/天",
      company: "韶天科技",
      require: "5-10年、Java、MySQL",
      contact: "钱三",
      location: "太原 万柏林区 下元"
    },
    {
      id: 4,
      title: "鸿蒙应用开发工程师",
      salary: "20–40K",
      company: "微博",
      require: "5-10年、本科、技术栈、沟通能力",
      contact: "孙可",
      location: "海淀区 西北旺"
    }
  ];

  aboutToAppear() {
    // 初始化显示的职位列表
    this.updateDisplayedJobs();
  }

  // 根据选中的标签更新显示的职位列表
  updateDisplayedJobs() {
    switch (this.currentTabIndex) {
      case 0: // 推荐
        this.displayedJobs = this.jobList;
        break;
      case 1: // 附近
        this.displayedJobs = this.jobList.slice(1, 4);
        break;
      case 2: // 最新
        this.displayedJobs = this.jobList.slice(1);
        break;
    }
  }

  build() {
    Stack() { // 使用Stack布局
      Column() {
        //时间、boss直聘、两个图标
        Row() {
          Text("11:04")
            .margin({ right: 55, left: 40 })
            .fontWeight(FontWeight.Bold)
          Text("boss直聘")
            .fontWeight(FontWeight.Bold)
            .fontSize(18)
            .fontColor('#ff3bae8f')
        }
        .linearGradient({
          angle: 60,
          colors: [
            ['#c36dedef', 0.0],
            ['#ffeec6b4', 1.0]
          ]
        })
        .width('100%')
        .height(40)

        //鸿蒙开发工程师
        Row() {
          Text('鸿蒙开发工程师')
            .fontWeight(FontWeight.Bold)
            .fontSize(24)
            .margin({ top: 10, right: 120 })
          Image($r('app.media.jia'))
            .height(30)
            .margin({ right: 10 })
          Image($r('app.media.sou'))
            .height(30)
        }
        .linearGradient({
          angle: 60,
          colors: [
            ['#c36dedef', 0.0],
            ['#ffeec6b4', 1.0]
          ]
        })
        .width('100%')
        .height(50)

        Text('推荐职位已更新')
          .fontColor('#ff4593a7')
          .margin({ top: 10 })

        // 标签栏tab+地点+筛选
        Row() {
          // 标签栏
          Row() {
            ForEach(this.tabs, (tab: string, index: number) => {
              Text(tab)
                .fontSize(16)
                .fontColor(this.currentTabIndex === index ? '#000' : '#999')
                .margin({ right: 20 })
                .onClick(() => {
                  this.currentTabIndex = index;
                  this.updateDisplayedJobs(); // 更新显示的职位列表
                })
            })
          }
          .margin({ right: 20 })

          // 在"最新"后面添加的按钮
          Button('北京')
            .backgroundColor(Color.White)
            .fontColor(Color.Gray)
            .border({
              width: 1,
              color: "#ff756d6d",
              radius: 0
            })
            .height(20)
            .width(50)
            .fontSize(8)
            .margin({ left: 20 })

          Button('筛选')
            .backgroundColor(Color.White)
            .fontColor(Color.Gray)
            .border({
              width: 1,
              color: "#ff756d6d",
              radius: 0
            })
            .height(20)
            .margin({ left: 10 })
            .fontSize(8)
        }
        .height(21)
        .justifyContent(FlexAlign.Start)
        .padding(10)
        .width('100%')

        // 职位列表区域 - 使用Scroll确保内容过多时可滚动
        Scroll() {
          Column() {
            // 使用ForEach渲染当前显示的职位列表
            ForEach(this.displayedJobs, (job: JobData) => {
              this.buildJobCard(job)
            })
          }
          .width('100%')
        }
        .height(540)
        .width('100%')

        //底部导航
        Row() {
          //职位
          Column() {
            Image($r('app.media.zhiwei'))
              .width(50)
              .height(40)
            Text('职位')
              .fontSize(12)
              .fontColor('#00A6FF')

          }
          .padding({ left: 40, right: 20 })

          //有了
          Column() {
            Badge({
              count:1,
              position: BadgePosition.Right,
              style: {
                badgeSize: 8,
                fontSize: 12,
                badgeColor: Color.Red
              }
            }) {
              Image($r('app.media.you'))
                .width(30)
                .height(30)
                .margin({top:5})
            }

            Text('有了')
              .fontSize(12)
              .fontColor('#ff070707')
              .margin({ top: 19 })
          }
          .padding({ left: 25, right: 25 })

          //消息
          Column() {
            Badge({
              count: 2,
              position: BadgePosition.Right,
              style: {
                badgeSize: 8,
                fontSize: 12,
                badgeColor: Color.Red
              }
            }) {
              Image($r('app.media.xiao'))
                .width(30)
                .height(30)
                .margin({top:5})
            }

            Text('消息')
              .fontSize(12)
              .fontColor('#ff070707')
              .margin({ top: 19 })
          }
          .padding({ left: 25, right: 25 })

          //我的
          Column() {
            Badge({
              count: 2,
              position: BadgePosition.Right,
              style: {
                badgeSize: 8,
                fontSize: 12,
                badgeColor: Color.Red
              }
            }) {
              Image($r('app.media.me'))
                .width(30)
                .height(30)
                .margin({top:2})
            }

            Text('我的')
              .fontSize(12)
              .fontColor('#ff070707')
              .margin({ top: 19 })
          }
          .padding({ left: 25, right: 25 })
        }
        .width('100%')
        .height(20)
      }
      .width('100%')
      .height('100%')

      // 使用条件渲染显示提示框
      if (this.showDialog) {
        this.customDialog()
      }
    }
    .width('100%')
    .height('100%')
  }
}

