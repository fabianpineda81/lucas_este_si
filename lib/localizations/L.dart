import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lucas/helpers/LocalPreferences.dart';

class L {
  //static Map<String, String> words;
  //static Map<String, String> folderNames;

  // This method is called from every widget which needs a localized text for an image name
  /* static String word(String key) {
    if (words==null)
      return "";

    return words[key];
  } */

  // This method is called from every widget which needs a localized text for a folder name
  // static String folderName(String key) {
  //   if (folderNames==null)
  //     return "";

  //   return folderNames[key];
  // }

  /* static setWords(Map<String, String> _words) {
    words = _words;
  } */

  // static setFolderNames(Map<String, String> _folderNames) {
  //   folderNames = _folderNames;
  // }

  /* static Map<String, String> getWords() {
    if (words==null) {
      words = new Map<String, String>();
    }

    return words;
  } */

  // static Map<String, String> getFolderNames() {
  //   if (folderNames==null) {
  //     folderNames = new Map<String, String>();
  //   }

  //   return folderNames;
  // }

  /* static void clearWords() {
    if (words==null) {
      words = new Map<String, String>();
    }
    words.clear();
  } */

  // static void clearFolderNames() {
  //   if (folderNames==null) {
  //     folderNames = new Map<String, String>();
  //   }
  //   folderNames.clear();
  // }

  static Map<String, Map<String, String>> _localizedValues = {
    // Mandarin Chinese (1.1 billion)
    'zh': {
      'app title': 'LUCAS',
      'relation': '关系',
      'schedule day': '计划日',
      'sound': '声音',
      'video': '视频',
      'story object': '故事对象',
      'translation': '翻译',
      'start': '开始备份',
      'backup device': '备份此设备',
      'Minimum level to show': '显示的最低水平',
      'background color': '背景颜色',
      'loading empty spaces': '加载空白处',
      'loading translations': '载入翻译',
      'Drag and drop enabled': '启用拖放',
      'Drag and drop disabled': '禁止拖放',
      'about this app': '关于这个程序',
      'text to find': '找',
      'text to find instructions': '输入要在问题中查找的单词或单词的一部分。 留空以搜索所有内容。',
      'number of concepts': '概念数',
      'one concept': '一个概念',
      'two concepts': '两个概念',
      'three or more': '三个或更多概念',
      'students': '学生们',
      'find results': '寻找结果',
      'result is correct': '结果正确',
      'result is wrong': '结果是错误的',
      'play quiz': '听测验',
      'silent quiz ongoing': '进行无声测验',
      'send to device': '发送至：',
      'quiz type': '测验类型',
      'quiz show image': '显示图片',
      'quiz sound image': '发音概念',
      'quiz show sound and image': '发音概念并显示图像',
      'quiz do not show anything': '什么都不显示',
      'send quiz': '',
      'schedule_title1': '欢迎',
      'schedule_title2': '一天中的时间',
      'schedule_title3': '编辑模式',
      'schedule_title4': '新增物件',
      'schedule_title5': '管理日子',
      'schedule_text1': '时间表允许可视化将要发生的事情。 它使您的用户了解他现在和将来会做什么。 您可以长按一个项目将其放大。',
      'schedule_text2': '隐藏/显示每天发生的每个活动的时间。',
      'schedule_text3': '编辑模式允许管理概念。 在编辑模式下，将显示所有日子，您可以单击每个对象进行交互。',
      'schedule_text4': '选择日期/时间和想要显示的图像。',
      'schedule_text5': '如果您需要添加新的日子，请单击此处。',
      'existing concept': '同一天和同一小时已有一个概念。 请更正并重试。',
      'please select an object': '请选择一个对象',
      'please select a day': '请选择一天',
      'select an object': '选择一个对象',
      'add object': '将对象添加到计划',
      'select day': '选择日期',
      'selected day': '选定日期',
      'select hour': '选择小时',
      'monday': '星期一',
      'tuesday': '星期二',
      'wednesday': '星期三',
      'thursday': '星期四',
      'friday': '星期五',
      'saturday': '星期六',
      'sunday': '星期日',
      'school': '学校',
      'home': '家',
      'today': '今天',
      'tomorrow': '明天',
      'no action required title': '无需采取任何措施',
      'no action required info': '请阅读提供的信息，然后单击“学习”图标继续',
      'reset': '重启',
      'video_title1': '入门视频',
      'video_title2': '1级',
      'video_title3': '2级',
      'video_title4': '3级',
      'video_title5': '4级',
      'video_title6': '5级',
      'video_title7': '6级',
      'video_title8': '7级',
      'video_title9': '8级',
      'video_title10': '9级',
      'video_title11': '10级',
      'video_title12': '11级',
      'video_title13': '用户设置',
      'video_text1': '我们的介绍性视频',
      'video_text2': '补强视频',
      'video_text3': '选择视频',
      'video_text4': '错误的选择视频',
      'video_text5': '语音框视频',
      'video_text6': '建立词汇视频',
      'video_text7': '创建文件夹视频',
      'video_text8': '句子结构-第一部分视频',
      'video_text9': '句子结构–第二部分视频',
      'video_text10': '语法和发达的扫盲视频',
      'video_text11': '学习单词视频',
      'video_text12': '预测性图像/编写视频',
      'video_text13': '用户设置视频',
      'showHelper_LevelSettings_title1': '第一：',
      'showHelper_LevelSettings_title2': '填写信息',
      'showHelper_LevelSettings_title3': '变更等级',
      'showHelper_LevelSettings_title4': '学习画面',
      'showHelper_LevelSettings_text1': '请阅读我们为您提供的所有信息',
      'showHelper_LevelSettings_text2': '某些级别需要您提供信息。 它们清楚地突出显示',
      'showHelper_LevelSettings_text3': '如果您需要更改级别，请按此图标',
      'showHelper_LevelSettings_text4': '准备就绪后，返回到“学习”屏幕',
      'showHelper_image-settings_title1': '找',
      'showHelper_image-settings_title2': '编辑',
      'showHelper_image-settings_title3': '网格尺寸',
      'showHelper_image-settings_title4': '帮帮我',
      'showHelper_image-settings_text1': '输入文字，然后按按钮查找图像',
      'showHelper_image-settings_text2': '点击图片进行编辑',
      'showHelper_image-settings_text3': '按下此按钮更改网格大小',
      'showHelper_image-settings_text4': '使用此按钮打开或关闭帮助',
      'showHelper_folders_title1': '请点击',
      'showHelper_folders_title2': '双击',
      'showHelper_folders_title3': '长按',
      'showHelper_folders_title4': '加',
      'showHelper_folders_title5': '返回上级文件夹',
      'showHelper_folders_text1': '单击一个项目以查看其属性',
      'showHelper_folders_text2': '双击文件夹以查看其子级',
      'showHelper_folders_text3': '长按项目以锁定/解锁',
      'showHelper_folders_text4': '添加文件夹，图像，声音和视频',
      'showHelper_folders_text5': '要返回上级文件夹，请按此图标',
      'Show Help Screens': '显示帮助屏幕',
      'privacy policy': '隐私政策',
      'must accept privacy policy': '您必须先接受我们的隐私政策，然后才能继续',
      'view privacy policy': '查看隐私权政策',
      'accept privacy policy': '接受隐私权政策',
      'show hide schedule': '显示/隐藏时间表',
      'show hide stories and schedule': '显示或隐藏故事和时间表',
      'show': '节目',
      'hide': '隐藏',
      'share item': '分享',
      'check connection': '检查连接',
      'not connected to internet': '看起来您没有连接到互联网',
      'user information': '用户信息',
      'settings restrictions instructions':
          '可以限制对配置的访问。 如果用户尝试单击配置图标以分散自己的学习兴趣，这将非常有用。 启用配置限制后，必须提供简单数学问题的答案。 如果答案正确，则将授予对配置部分的访问权限。 这种限制机制允许家长和教师限制对配置部分的访问，而无需记住和共享密码。',
      'settings password protected': '设定限制',
      'settings password protected no': '无限制',
      'settings password protected yes': '要求数学答案',
      'delete linked device': '删除链接的设备',
      'confirm delete linked device': '您要删除链接的设备吗？ 如果删除它，则稍后需要重新链接以再次将其重新添加。',
      'echo device': '该设备将回声语音箱',
      'device silent': '该设备将保持静音',
      'device blocked': '该设备现在被阻止。',
      'device unblocked': '该设备已被解除阻止。',
      'output voicebox to device': '将语音信箱输出到另一台设备',
      'quizzes': '测验',
      'quizzes instructions': '可以在此设备上创建测验（作为老师/教育者）（可以在任何设备上回答测验）',
      'can create quiz': '可以创建测验',
      'can not create quiz': '无法创建测验',
      'invite rejected': '邀请被拒绝',
      'invite sent': '邀请发送至',
      'recieved invite': '您已收到链接的邀请',
      'accept': '接受',
      'ignore and dismiss': '忽略并解雇',
      'invite confirmed': '邀请已确认',
      'invite accepted': '邀请被接受',
      'remember link other party': '切记：在另一台设备上重复相同的过程。',
      'please enter remote email': '请输入对方的电子邮件',
      'add new device': '添加新设备',
      'remote user email': '远程用户电子邮件',
      'remote user email instructions':
          '要在两个设备之间创建链接，请确保两个设备都已打开，已连接到互联网，正在运行APP并显示链接的设备屏幕（此屏幕）。 必须在两个设备上都执行链接建立（每个设备必须输入对方的电子邮件）',
      'enter remote user email': '输入远程用户电子邮件',
      'warning': '警告',
      'email or name not filled': '电子邮件或姓名未填写。 在尝试链接新设备之前，请完成此信息。',
      'email or name required for backup': '电子邮件或姓名未填写。 在尝试备份设备之前，请完成此信息。',
      'email or name required for restore': '需要电子邮件才能还原',
      'start restore': '开始还原',
      'replace folder': '替换文件夹',
      'add to folder': '添加到文件夹',
      'what to do with folder':
          '选择将被替换的本地文件夹。 建议在还原任何文件夹之前备份此设备，因为在将其替换为远程文件夹之前，本地文件夹的内容将被删除。',
      'choose folder to restore': '选择要还原的文件夹',
      'quiz': '考试',
      'linked devices': '链接的设备',
      'no linked devices': '找不到链接的设备',
      'change user name': '变更使用者名称',
      'confirm change user name': '您要更改用户名吗？',
      'user name': '用户名',
      'user name hint': '输入用户名',
      'change user email': '更改电子邮件',
      'confirm change user email':
          '如果您更改用户的电子邮件，则需要重新链接设备（家长或教育者将需要重新创建与此设备的链接）。 你想继续吗？',
      'user email': '用户的电子邮件',
      'user email instructions':
          '输入用户要使用的电子邮件。 如果用户没有电子邮件，则可以是父母的电子邮件。 请勿在此字段中放置教育者或老师的电子邮件。 该电子邮件用于将每个用户标识为唯一。 该电子邮件用于链接设备以进行同步或测验。',
      'user email hint': '输入电子邮件',
      'toggle visibility for all': '更改所有概念的可见性',
      'item availability': '物品可用性',
      'item availability instructions': '如果某个项目不可用，则可以指示它。 无法使用的商品会在图片上方显示为红色X',
      'is available': '有空',
      'is not available': '不可用',
      'not available': '无法使用',
      'available': '可用的',
      'delete story': '删除故事',
      'confirm delete story': '您确定要删除该故事吗？',
      'level not enabled': '级别未启用',
      'not enough data': '由于未收集到足够的数据，因此无法启用预测性写入',
      'image size': '图片尺寸',
      'text size': '字体大小',
      'small': '小',
      'medium': '介质',
      'large': '大',
      'select video': '选择视频',
      'selected video': '选定的视频：',
      'recording': '记录...',
      'story object instructions': '您可以通过滑动来消除概念。 什么都不会被删除。 （仅在编辑模式下删除概念）',
      'edit story name': '编辑故事名称',
      'select this concept': '选择这个概念',
      'no story object instructions': '',
      'add story object': '添加概念',
      'story name hint': '输入故事名称',
      'create new story': '创建一个新故事',
      'no stories instructions':
          '故事使您可以加入概念（图像，声音和视频）来解释新想法。 例如，您可以解释对动物园的访问，该过程从淋浴，穿衣服，吃早餐，乘汽车旅行和看动物开始。',
      'add story': '添加故事',
      'please confirm': '请确认',
      'replace sound confirmation': '您要替换现有的音频吗？',
      'replace': '更换',
      'voiceBoxSize': '语音箱尺寸',
      'big': '大',
      'select sound': '录制音频',
      'select sound instructions': '录制您想要的声音。 当用户单击图像时，可以播放此音频。',
      'delete': '删除',
      'delete confirmation': '请确认您要删除该对象。 此操作是不可逆的。',
      'warning not user created':
          '警告：默认情况下，此对象与APP捆绑在一起。 如果删除它，则无法恢复它，您必须手动将其与每种语言的图像和文本一起添加。',
      'folder not empty will not delete': '删除之前文件夹必须为空',
      'local device': '设备',
      'library': '图书馆',
      'camara': '相机',
      'folder should talk': '说出资料夹的名称',
      'folder should talk instructions': '如果要在单击文件夹时听到其名称，请启用。',
      'loading images': '正在载入图片',
      'loading folders': '加载文件夹',
      'loading relations': '加载关系',
      'loading categories': '加载类别',
      'loading videos': '正在加载视频',
      'loading sounds': '载入声音',
      'allowLongPressInLearningScreen': '允许在学习模式下长按概念',
      'long press instructions': '在学习模式下，如果用户长按一个概念，将显示一个屏幕，显示所选选项的详细信息。',
      'Not assigned': '未分配',
      'nothing unlocked': '没有解锁',
      'nothing unlocked instructions':
          '使用此网格之前，必须选择（显示/解锁）所需的概念。 通过按住概念来锁定/解锁概念。 请记住，文件夹未在此级别显示。',
      'please unlock': '请在“配置”，“文件夹”中解锁/显示所需的项目',
      'default folder': '默认文件夹',
      'open folders': '打开文件夹',
      'default folder instructions': '要选择此文件夹作为默认文件夹，请单击按钮',
      'understood': '明白了',
      'not understood': '不明白',
      'is understood': '概念被理解',
      'is not understood': '概念尚未理解',
      'conceptIsUnderstood': '概念理解',
      'conceptIsUnderstoodInstructions':
          '一旦用户有了明确的概念，请将其标记为已理解。 这有助于老师和家长沟通。 在学习网格中，所有理解的概念都以绿色框起来。',
      'object visible': '当前可见的对象',
      'object not visible': '对象当前不可见',
      'visibility': '能见度',
      'visibility instructions': '显示或隐藏（解锁/锁定）您想要的图像',
      'image to show': '要显示的图像',
      'text to show': '显示文字',
      'text to show instructions': '这是学习网格中每个图像下方显示的文本。',
      'text to show hint': '输入要显示的文字',
      'text to say': '文字说',
      'text to say instructions':
          '您可以更改怎么说！ 您可以将其更改为“我的名字是[在这里输入名字]”或“我的姐姐是[姐妹的名字]”，而不必说“我的名字是...”。 显示短文本但说长文本（例如，当图像表示长短语时）也很有用。',
      'text to say hint': '输入文字说',
      'edit': '编辑',
      'no default folder': '未选择默认文件夹',
      'please select a default folder': '选择一个默认文件夹。 仅显示您从该文件夹解锁的图像。',
      'select folder': '选择默认文件夹',
      'select a folder': '选择要导入的远程文件夹',
      'current default folder': '当前默认文件夹：',
      'unlock': '开锁',
      'lock': '锁',
      'debug mode': '调试模式',
      'user profile': '用户设置',
      'add': '加',
      'Grid size': '网格尺寸',
      'grid size instructions':
          '如果需要，可以更改网格的大小（列和行）。 仅当您的设备具有大屏幕时，才可以更改此设置。 确认用户可以舒适地看到并触摸每个图标。',
      'operation completed successfully': '操作成功完成',
      'restore device': '还原装置',
      'user email to restore': '用户电子邮件还原',
      'categories': '分类目录',
      'category': '类别',
      'close': '关',
      'add folder': '新增文件夹',
      'add image': '添加图片',
      'add empty': '添加空白空间',
      'add video': '新增影片',
      'add sound': '添加声音',
      'new folder name': '',
      'new image name': '',
      'new video name': '',
      'new sound name': '',
      'show folder': '显示文件夹',
      'hide folder': '隐藏资料夹',
      'delete folder': '删除资料夹',
      'folder instructions': '单击或双击图像或空白区域以激活其选项。 单击菜单以浏览更多选项。',
      'grid instructions': '根据用户的需求（用于较大的图标）或设备屏幕的大小，您可以更改从级别5开始显示的图像的网格大小。',
      'grid': '格网',
      'Columns': '列',
      'Rows': '行数',
      'folders': '资料夹',
      'level not found': '找不到级别',
      'missing reinforcer': '缺少补强剂',
      'confirm reinforcer': '请确认您要使用',
      'selected reinforcer': '您当前选择的增强剂是：',
      'please select a reinforcer': '请为此级别选择一个补强',
      'cancel': '取消',
      'learn': '学习',
      'stories': '故事',
      'schedule': '时间表',
      'help videos': '帮助视频',
      'images': '图片',
      'colors': '色彩',
      'amber': '琥珀色',
      'blue': '蓝色',
      'cyan': '青色',
      'deepOrange': '深橙色',
      'deepPurple': '深紫色',
      'green': '绿色',
      'indigo': '靛青',
      'lightBlue': '浅蓝',
      'lightGreen': '浅绿色',
      'lime': '酸橙',
      'orange': '橙子',
      'pink': '粉',
      'purple': '紫色',
      'red': '红色',
      'teal': '蓝绿色',
      'yellow': '黄色',
      'dark mode': '暗模式',
      'select this theme': '选择这个主题',
      'select voice': '选择声音',
      'no voice selected': '未选择语音。 如果您未选择语音，则APP将无法说出任何单词。',
      'tts': '文字转语音',
      'voice speed': '语音速度',
      'say': '大声说出来',
      'send by email': '通过电子邮件发送',
      'user name not configured': '用户名未配置',
      'change': '更改',
      'no valid voice found': '找不到有效的声音',
      'test voice': '测试语音。 点击激活。',
      'test text': '如果您能听到这句话，则说明您已经正确配置了语音。',
      'settings title': '组态',
      'levels': '等级',
      'language': '语言',
      'select language instructions': '选择您喜欢的语言',
      'Chinese': '中文',
      'English': '英语',
      'Hindi': '印地语',
      'Spanish': '西班牙文',
      'Arabic': '阿拉伯',
      'Malay': '马来语',
      'Russian': '俄语',
      'Bengali': '孟加拉',
      'Portuguese': '葡萄牙语',
      'French': '法文',
      'German': '德语',
      'find image': '查找图片',
      'selected level': '所选级别',
      'level1': '1级',
      'level2': '2级',
      'level3': '3级',
      'level4': '4级',
      'level5': '5级',
      'level6': '6级',
      'level7': '7级',
      'level8': '8级',
      'level9': '9级',
      'level10': '10级',
      'level11': '11级',
      'change level': '变更等级',
      'summary': '摘要',
      'level1 name': '加强件',
      'level1 summary': '该级别的主要功能是激励用户触摸屏幕。 当用户独立触摸屏幕以请求一个对象时，将获得学习结果。',
      'Who does this level cater for': '此级别适合谁？',
      'level1 Who does this level cater for':
          '零沟通的儿童或成人。 此级别的主要功能是鼓励用户受到APP /设备的激励',
      'How do we achieve this?': '我们如何实现这一目标？',
      'level1 How do we achieve this':
          '父母/老师/专家必须知道孩子的补强者。 加固物是用户喜欢或迷恋的对象或物品。 一个很好的例子就是食品，例如巧克力。',
      'select reinforcer': '选择补强剂',
      'How do we get the user to touch the screen?': '我们如何让用户触摸屏幕？',
      'level1 How do we get the user to touch the screen':
          '级别1被设置为一个屏幕/按钮，一旦被触摸就会讲话。以巧克力为例，家长/教师/专家应设置应用程序以显示巧克力图像。家长/老师/专家必须在每次教学中准备好许多小块巧克力，为用户提供即时奖励。请记住，为教学课程留出时间很重要，但是每天的每一刻都是一个教学机会。将iPad放在用户有机会使用它的地方。 \n\n在教学期间\n1。向用户提供一小块巧克力。最好让用户就座，尽管这并非总是可能的。\n2。使用“移交”来鼓励用户触摸屏幕。 “交手”是一种针对自闭症儿童的教学方法。父母/老师/专家通过鼓励用户按下按钮来帮助用户。父母/老师/专家将其手放在用户的手上，并将他们引向所选按钮。* \n3。 APP讲话后，家长/老师/专家必须立即将巧克力赠送给用户。\n4。除非用户感到沮丧，否则应定期重复此操作最多5分钟。在用户按下按钮之前，不要为用户提供巧克力，无论他们有多沮丧。\n5。如果用户感到沮丧，请不要放弃。这是一个漫长的过程，但是长期的收益将使用户终身受益。当用户保持冷静时，停止并重新访问此任务。\n\n全天定期重复执行步骤1-5。许多用户将很快在此级别上获得成功，而其他用户将需要大量的努力，耐心和努力。\n\n *这种帮助的力量应逐渐减少。可能需要数月才能完全删除。',
      'How do you know ready for level 2': '您如何知道用户已准备好进行2级课程？',
      'level1 How do you know ready for level 2':
          '当您注意到您的孩子开始理解此APP可以帮助他们获得加固物时，用户将减少“移交”的需要。 当用户在父母/老师的任何支持下独立且一致地按下按钮时，则用户已准备就绪，可以进行第2级',
      'level2 name': '选择项',
      'level2 summary': '此级别旨在告诉用户，奖励结果有多种选择。 \n\n学习成果：用户将能够一致且有理解地要求这两个项目。',
      'level2 Who does this level cater for':
          '此级别适合已访问1级且对“移交”的需求最少的用户。 向用户提供了两个鼓励他们做出选择的选项，从而使用户进步。',
      'level2 How do we achieve this':
          '家长/老师/专家必须确保添加到屏幕上的第二个图像是第二个增强器，例如果汁。 \n\ n用户现在可以选择请求两个自己喜欢的项目，这将建立他们与该应用程序的关系。',
      'select second reinforcer': '选择第二个补强',
      'level2 How do we get the user to touch the screen':
          '家长/教师/专家将使用第1级中使用的相同策略。总而言之，这两项必须随时可用，并应要求立即提供给用户。 重要的是要确保用户获得了正确的物品并意识到两个图像的差异。 应该向用户显示其中一项，并且必须准确，一致地要求用户。 数据将可用于突出显示响应并显示准确性。 该级别是最快的级别之一，因为用户应该已经被1级增强器激励了。',
      'How do you know ready for level 3': '您如何知道用户已准备好进入3级？',
      'level2 How do you know ready for level 3':
          '用户将对独立使用该应用程序表现出增强的信心，并且“移交”的需求应有限。 当用户在家长/老师/专家的有限支持下独立，持续地按下按钮时，这表明用户已准备好进入第3级。 ',
      'level3 name': '错误的选择',
      'level3 summary':
          '在此阶段，用户将了解该应用程序提供了使他/她感到高兴的结果。 重要的是要提供此级别，因为此进度告诉用户所有选择都不会带来回报，但它们是交流。 在短时间内即可达到此水平。 学习结果：接收到非首选选项后，应观察到用户表现出厌恶感。 用户将不再选择此选项。',
      'level3 Who does this level cater for':
          '此级别适合已访问级别1和2且“移交”需求最小/为零的用户。 通过向用户提供第三种选择，这不是一个不错的选择，从而为用户发展。',
      'level3 How do we achieve this':
          '在开发的这个阶段，用户现在将拥有一个非首选选项。 家长/老师/专家必须确保添加到屏幕上的第三个图像不是首选项目，例如袜子。 用户现在可以选择请求两个首选选项和一个非首选选项。',
      'select third reinforcer': '选择第三个字',
      'level3 How do we get the user to touch the screen':
          '现在，用户应该受到应用程序的激励，并且会对触摸图像产生兴趣。 迄今为止，他们已经从图像中获得乐趣。 用户将保持好奇心，并希望从非首选项目中获得积极的结果。 她/他应该在没有父母/老师/专家激励的情况下得到激励，但是，如果不是这种情况，那么父母/老师/专家应该遵循第1级的策略来鼓励这种互动。 如果用户选择/触摸三个图像中的任何一个，他们将立即收到该项目。 前三个级别旨在教用户如何请求商品。 此级别巩固了并非所有选择都是令人愉悦的事实，而是要求。 用户现在将学习认为他们触摸的图像将是他们收到的项目，无论他们是否喜欢它们。',
      'How do you know ready for level 4': '您如何知道用户已准备好进入4级？',
      'level3 How do you know ready for level 4':
          '用户收到不喜欢的商品时会感到失望，并将继续对其他要求的商品感到满意。 家长/老师/专家应继续观察到独立使用该应用程��的信心增强。 当用户在父母/老师/专家的任何支持下独立且一致地按下按钮时，用户已准备就绪，可以进入第4级。数据将证明这些观察结果。 接收到非首选选项时，还应观察到用户表现出厌恶感。 用户将不再选择此选项。',
      'level4 name': '语音信箱',
      'level4 summary':
          '此级别旨在开始构建将在下一级别中使用的语言结构。 只有在用户选择图像并触摸语音框后，才会给予用户奖励。 学习结果：用户将选择一个选定的项目，并且将理解该项目只有在触摸语音框后才会提供。',
      'level4 Who does this level cater for':
          '此级别适合已访问1-3级并现在以最少/零个“移交”支持独立使用该应用程序的用户。 对于家长/教师/专家而言，此级别是更具挑战性的级别之一，对于用户而言，此级别则令人沮丧。 该级别的目的是教用户使用允许进行语言开发的语音盒。 在这个阶段，父母/老师/专家正在计划通过使用户准备使用两个单词级别（即）来开发语言。 要巧克力。 此级别需要时间和耐心。 可能需要在短时间内恢复为“移交”。',
      'level4 How do we achieve this':
          '在此阶段，第3层屏幕仍然具有相同的三个选项，尽管该屏幕现在在屏幕顶部具有一个长条。 该条带称为“语音框”。 当用户触摸普通图像时，将不再立即说出该单词。 现在，它将显示在屏幕顶部的语音框中。 现在，用户必须触摸语音框，才能说出所选单词。',
      'level4 How do we get the user to touch the screen':
          '请求该项目时，用户将不再收到即时满足。 必须鼓励他（她）触摸语音框。 这将需要“移交”来初步教会用户并显示期望的内容。 所有用户将以不同的速度学习该知识。 家长/老师/专家应根据用户的理解逐步减少“移交”。',
      'How do you know ready for level 5': '您如何知道用户已准备好进入5级？',
      'level4 How do you know ready for level 5':
          '用户将独立或在“移交”支持下选择项目并触摸语音框。 数据将显示较高的成功率。',
      'level5 name': '建立词汇',
      'level 5 folders': '文件夹的行为',
      'level 5 folder info': '文件夹未在此级别显示。 这是有意的，因此用户将不会导航到其他文件夹并且不会偏离关卡的目标',
      'level5 summary':
          '此级别是教学过程的开始，主要目的是为用户建立语言。\n\n学习成果：用户将对一个文件夹中的6个或更多单词有清晰的了解。',
      'level5 Who does this level cater for':
          'This level caters for Users who have accessed Levels 1-4. Users will generally be using the App independently at this stage although some may require ‘hand over hand’ support. \n\nThis level is the start of the teaching process with the primary aim being to build language for the User. The parent/teacher/specialist role becomes more important at this stage as new words should now be introduced to the User, and the parent/teacher/specialist must select words that would be important to the User. The words must also be within the same category ie. using the example of chocolate would require building language for snack items, and the snack items must be those preferred by the User. The categories have been pre-arranged into folders and the words can be made visible as required. If the words/items are not currently available on the folder, the parent/teacher/specialist can take a photo and add them in.\n\nAt this stage, the parent/teacher/specialist must follow the guidance that is provided in the teaching section regarding the use of videos, cards and items. This level takes time and a lot of patience. ‘Hand over hand’ may continue until the User builds his/her confidence.',
      'level5 How do we achieve this':
          'The Parent/Teacher/Specialist section within the App provides detail on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. \n\nThis section includes:\n1.	Continuing to request items\n2.	Matching pictures\n3.	Matching picture to object\n4.	Matching picture to item',
      'level5 How do we get the user to touch the screen':
          'This level requires the User to focus and remain seated to improve communication and build vocabulary. It is unlikely that the User will be willing to engage and therefore it is essential that the main reinforcer is re-introduced. The main reinforcer discussed as an example in the previous summaries was chocolate. In this case the chocolate must be readily available throughout these sessions as the User will be motivated to work if they are provided with a reward. \n\nInitially, the User should be rewarded with their reinforcer after EVERY successful item has been requested ie. when matching every item, the User should be rewarded with a small treat such as a third of a chocolate button. Gradually reduce the reinforcer treat as the User becomes more confident. In time, the User will no longer require a reinforcer. \n\For many this may require ‘hand over hand’ to initially teach the User and show what is expected. All Users will learn this at a different rate. The parent/teacher/specialist should gradually reduce the ‘hand over hand’ depending on the understanding of the User.',
      'How do you know ready for level 6':
          'How do you know the user is ready for level 6?',
      'level5 How do you know ready for level 6':
          'The User will have developed words within this category ie. snacks. This category will continue to be known as the ‘snack’ folder. When a folder contains 6 or more items the User is ready to progress to Level 6. The User would be expected to select items independently although some Users may still prefer ‘hand over hand’ support at this time. Data will continue to be available to show a high percentage success rate in identifying the chosen items. ',
      'level6 name': 'Creating folders',
      'level6 summary':
          'This Level allows Users to develop their language by increasing folders. Folders are created to allow Users to compartmentalize different topics ie. food, transport, clothes. \n\nLearning outcome: The User will show confidence in selecting items. They will be able to move between a minimum of three folders with ease.',
      'level6 Who does this level cater for':
          'This level differs from the others in that it caters for two groups:\n1.	Users who have accessed levels 1-5. These Users will be developing in confidence and most will be using the App independently. Some Users may still require extra support with ‘hand over hand’. Do not discourage this as all Users will develop at a different rate – as confidence grows, the need for support will reduce. \n2.	This would be the suggested stage to introduce the App to Users with limited/zero communication who are visual learners with moderate to good understanding. The parent/teacher/specialist should familiarize themselves with the teaching strategies employed in Levels 1-5 to promote maximum progress and understanding.\n\nThis Level allows Users to develop their language by increasing folders. Folders are created to allow Users to compartmentalize different topics ie. food, transport, clothes. \n\nThe Users who have accessed Levels 1-5 should be engaged and have a clear understanding of what is expected of them. This level allows the parent/teacher/specialist to add different folders to increase the language/speech opportunities. Consider this level as being similar language development for any individual learning a new language. Typical language development starts with one word ie. juice, cat, car. The words come from different folders. We, at Lucas Education, have created a template of folders that we believe are essential for day-to-day communication.',
      'level6 How do we achieve this':
          'One additional folder will be made available to the existing folder in Level 5. For new Users, two folders will be available. The parent/teacher/specialist selects a second folder which contains items that are motivating to the User. When data shows that the User has clearly understood 5 words, the App with allow the opportunity to unlock 5 more words within this folder as well as another folder. \n\nThis process will continue as your User continues to develop and grow. This is a natural process and the same process that all individuals go through when learning to speak and communicate. Level 6 is on-going learning and development.   \n\nThe Parent/Teacher/Specialist section within the App provides further detail on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. Games will be available in due course.\n\nThis section includes:\n1.	Continuing to request items\n2.	Matching pictures\n3.	Matching picture to object\n4.	Matching picture to item',
      'level6 How do we get the user to touch the screen':
          'This Level continues to require the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the program on the move. Examples of such opportunities are when seated in the car or maybe your child enjoys sitting in their pram.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be motivated to work if they are provided with a reward. It is important however to reduce the frequency of the reward. As the language develops, the reinforcer should be reduced and removed.  \n\nThis may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication.',
      'How do you know ready for level 7':
          'How do you know the user is ready for level 7?',
      'level6 How do you know ready for level 7':
          'The User will show confidence in selecting items. They will be able to move between a minimum of three folders with ease. Data will continue to be available to show a high percentage success rate in identifying the chosen items.',
      'level7 name': 'Sentence structure – part one',
      'level7 summary':
          'This Level allows Users to develop sentence structure by introducing a sentence starter. Folders are predesigned to predict possible sentence starters for each folder. \n\nLearning outcome: The User will show confidence in selecting the sentence starter followed by the chosen item. The words will be activated by pressing the voicebox.',
      'level7 Who does this level cater for':
          'This level caters for Users who have accessed Level 6.\n\nThis Level allows Users to develop sentence structure by introducing a sentence starter. Folders are predesigned to predict possible sentence starters for each folder. The option is also available to personalise words.',
      'level7 How do we achieve this':
          'In the previous section, typical language development was discussed. This section takes language development to the next level. Children move from one word level to two. We, at Lucas Education achieve this by introducing sentence starters which vary depending on the folder. Examples of this would be as follows:\n1.	Food folder – I want chocolate……I do not want chocolate.\n2.	Animal folder – I hear cat\n3.	Transport folder – I see car.\n\nSimilar to Level 4, the User may become frustrated during the initial stages of this Level as they are now expected to include a word prior to what has been expected of them in previous levels. For many reinforcers must be introduced again to ensure that the User remains motivated. \n\nAs with the previous folder the words/images will be released when data proves that the User is capable of understanding and consistently includes the sentence starter before requests. Level 7 is on-going learning and development.   \n\nThe Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources.',
      'level7 How do we get the user to touch the screen':
          'This Level also requires the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the programme on the move. Examples of such opportunities are when seated in the car or maybe your child enjoys sitting in their pram.\n\nOnce both icons, namely the sentence starter and the requested item, are appearing in the voice box, the User must touch the voice box and the App will say the sentence for example “I want chocolate” At this point the parent/teacher will give the User what he/she is requesting. The voice box should not be activated until an action and an image are added. Both icons must be spoken in the one voice box; they cannot be selected and spoken independently.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be more motivated to work if they are provided with a reward. This may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication. ',
      'How do you know ready for level 8':
          'How do you know the user is ready for level 8?',
      'level7 How do you know ready for level 8':
          'The User will show confidence in selecting the sentence starter followed by the chosen item. Data will continue to be available to show a high percentage success rate in identifying the chosen items and more sentence starters will be unlocked to develop language further.',
      'level8 name': 'Sentence structure – part two',
      'level8 summary':
          'This level caters for Users who have accessed Level 7.\n\nThis Level allows Users to develop sentence structure by including a sentence closer. Folders are predesigned to predict possible sentence closers for each folder. The option is also available to personalise words.',
      'level8 Who does this level cater for':
          'This level caters for Users who have accessed Level 7.\n\nThis Level allows Users to develop sentence structure by including a sentence closer. Folders are predesigned to predict possible sentence closers for each folder. The option is also available to personalise words.',
      'level8 How do we achieve this':
          'In Level 5, typical language development was promoted and in Level 6 the sentence starters were added. This Level progresses language development to the next level by closing the sentences. We, at Lucas Education achieve this by providing predicted sentence closers which vary depending on the folder. Examples of this would be as follows:\n1.	Food folder – I want chocolate please\n2.	Animal folder – I hear cat\n3.	Transport folder – I see car.\n\nThe final part of the sentences can or cannot be used in conjunction with the action and objects. For example in some cases, the closing part can be used alone eg. All done!\n\nSimilar to Levels 4 and 7, the User may become a little frustrated during the initial stages of this Level as they are now expected to include a word following what has been expected of them in previous levels. For many, reinforcers must be introduced again to ensure that the User remains motivated. \n\nAs with the previous folder the words/images will be released when data proves that the User is capable of understanding and consistently includes the sentence closer after requests. Level 8 is on-going learning and development.\n\The Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. ',
      'level8 How do we get the user to touch the screen':
          'This Level also requires the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the programme on the move. Such opportunities could be made possible at snack time or perhaps when ordering food at a takeaway.\n\nWhen all three icons, namely the sentence starter, the requested item and the sentence closer, are appearing in the voice box, the User must touch the voice box and the App will say the sentence, for example “I want chocolate, please!”. At this point the parent/teacher will give the person what she/he is requesting. The voice box should not be activated until an action, an image and a closer are added. All three icons must be spoken in the one voice box; they cannot be selected and spoken independently.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be more motivated to work if they are provided with a reward. This may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication.',
      'How do you know ready for level 9':
          'How do you know the user is ready for level 9?',
      'level8 How do you know ready for level 9':
          'The User will show confidence in selecting the sentence starter followed by the chosen item and sentence closer. Data will continue to be available to show a high percentage success rate in identifying the chosen items and more sentence closers will be unlocked to develop language further. \n\nUsers at this Level are now capable of accessing Levels 9, 10 and 11. All three Levels are challenging and cater for higher functioning Users. These Levels do not have to taught in a sequential order, for example, the User may find difficulty in progressing through Levels 9 and 10, but may succeed in Level 11.',
      'level9 name': 'Grammar and developed literacy',
      'level9 summary':
          'This Level allows higher functioning Users the opportunity to focus on building sentence structure by developing literacy through use of conjunctions, connectives and pronouns.\nThis is an important building block to teaching the User how to read. \n\nTHIS IS ONE OF THE MORE CHALLENGING LEVELS.\n\nLearning outcome: The User will have the ability to communicate with confidence by linking words with conjunctives and using other literacy cues to develop language further.',
      'level9 Who does this level cater for':
          'This level caters for Users who have accessed Level 8.\n\nThis Level allows higher functioning Users the opportunity to focus on building sentence structure by developing literacy through use of conjunctions, connectives and pronouns.\n\nTHIS IS ONE OF THE MORE CHALLENGING LEVELS.',
      'level9 How do we achieve this':
          'The Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. \n\nData will also assist in gathering success criteria and in unlocking progressive language.',
      'level9 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program. ',
      'How do you know ready for level 10':
          'How do you know the user is ready for level 10?',
      'level9 How do you know ready for level 10':
          'The User is capable to access Level 10 directly from Level 8. All Levels can be used at the same time to develop language. Words will be unlocked when data dictates that the User is ready. ',
      'level10 name': 'Learning words',
      'level10 summary':
          'This Level allows higher functioning Users the opportunity to focus on learning words as opposed to pictures. This Level progresses by removing pictures and replacing them with the name/text of each object. This is the initial step in providing our non-verbal children with the opportunity to read.\n\nLearning outcome: The User will have the ability to communicate with the same confidence by using words as opposed to images.',
      'level10 Who does this level cater for':
          'This level caters for Users who have accessed Level 8 or 9.\n\nThis Level allows higher functioning Users the opportunity to focus on learning words as opposed to pictures. Users who require images should bypass this Level and access Level 10.',
      'level10 How do we achieve this':
          'The Parent/Teacher/Specialist will have an understanding of the favourite words selected by the User. Data will also assist in gathering such details. All words have been set up to show a large image with a small defined word below (show example). The Parent/Teacher/Specialist will now gradually reduce the size of the picture for the favourite words, whilst increasing the size of the word. With time the Parent/Teacher/Specialist will aim to remove the image and only provide the User with the word. Once again, experience and data will provide feedback on the understanding of the User and their readiness to remove images from other buttons.',
      'level10 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program. If they are unable to use the words when the images have been reduced, this is a sign that the User is not ready for this Level and it must be revisited at another stage.',
      'How do you know ready for level 11':
          'How do you know the user is ready for level 11?',
      'level10 How do you know ready for level 11':
          'The User will show confidence in selecting icons with words as opposed to images. Data will continue to be available to show a high percentage success rate in identifying the chosen items.',
      'level11 name': 'predictive images/writing',
      'level11 summary':
          'This Level allows Users the opportunity to communicate with greater speed by providing the User with the opportunity to select predicted images or words. \n\nLearning outcome: The User will have the ability to communicate with the same confidence although at a greater speed and fluency.',
      'level11 Who does this level cater for':
          'This level caters for Users who have accessed Level 8.\n\nThis Level allows Users the opportunity to communicate with greater speed. ',
      'level11 How do we achieve this':
          'This Level provides the User with the opportunity to select predicted images or words. The App will provide a list of actions to be selected by the user. Once an action is selected, the pictures/words to be shown will be presented depending on the frequency of usage for each word. The most used words will appear higher in the grid while less used words for that specific action will appear lower on the grid.',
      'level11 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program',
    },
    // English (983 million)
    'en': {
      'app title': 'LUCAS',
      'relation': 'Relation',
      'schedule day': 'Schedule day',
      'sound': 'Sound',
      'video': 'Video',
      'story object': 'Story object',
      'translation': 'Translation',
      'start': 'Start backup',
      'backup device': 'Backup this device',
      'Minimum level to show': 'Minimum level to show',
      'background color': 'Background color',
      'loading empty spaces': 'Loading empty spaces',
      'loading translations': 'Loading translations',
      'Drag and drop enabled': 'Drag and drop enabled',
      'Drag and drop disabled': 'Drag and drop disabled',
      'about this app': 'About this App',
      'text to find': 'Find',
      'text to find instructions':
          'Enter the word or part of the word to find in the question. Leave blank to search for all.',
      'number of concepts': 'Number of concepts',
      'one concept': 'One concept',
      'two concepts': 'Two concepts',
      'three or more': 'Three or more concepts',
      'students': 'Students',
      'find results': 'Find results',
      'result is correct': 'Result is correct',
      'result is wrong': 'Result is wrong',
      'play quiz': 'Listen to quiz',
      'silent quiz ongoing': 'Silent quiz ongoing',
      'send to device': 'Send to: ',
      'quiz type': 'Type of quiz',
      'quiz show image': 'Show images',
      'quiz sound image': 'Pronounce the concepts',
      'quiz show sound and image': 'Pronounce the concepts and show images',
      'quiz do not show anything': 'Do not show anything',
      'send quiz': 'Send quiz',
      'schedule_title1': 'Welcome',
      'schedule_title2': 'Time of day',
      'schedule_title3': 'Edit mode',
      'schedule_title4': 'Add object',
      'schedule_title5': 'Manage days',
      'schedule_text1':
          'The schedule allows to visualize things that will happen. It allows your user to understand what he will do today and in the future. You can long press an item to see it larger.',
      'schedule_text2': 'Hide/show the time of day each activity will happen.',
      'schedule_text3':
          'The edit mode allows to manage concepts. In edit mode all days will be shown and you can click each object to interact with it.',
      'schedule_text4':
          'Select the day/time and image you want it to be shown.',
      'schedule_text5': 'If you need to add new days, click here.',
      'existing concept':
          'There is already a concept for the same day and hour. Please correct and retry.',
      'please select an object': 'Please select an object',
      'please select a day': 'Please select a day',
      'select an object': 'Select an object',
      'add object': 'Add object to schedule',
      'select day': 'Select day',
      'selected day': 'Selected day',
      'select hour': 'Select hour',
      'monday': 'Monday',
      'tuesday': 'Tuesday',
      'wednesday': 'Wednesday',
      'thursday': 'Thursday',
      'friday': 'Friday',
      'saturday': 'Saturday',
      'sunday': 'Sunday',
      'school': 'School',
      'home': 'Home',
      'today': 'Today',
      'tomorrow': 'Tomorrow',
      'no action required title': 'No action is requiered',
      'no action required info':
          'Please read the provided info and continue by clicking on the Learn icon',
      'reset': 'Reset',
      'video_title1': 'Introductory video',
      'video_title2': 'Level 1',
      'video_title3': 'Level 2',
      'video_title4': 'Level 3',
      'video_title5': 'Level 4',
      'video_title6': 'Level 5',
      'video_title7': 'Level 6',
      'video_title8': 'Level 7',
      'video_title9': 'Level 8',
      'video_title10': 'Level 9',
      'video_title11': 'Level 10',
      'video_title12': 'Level 11',
      'video_title13': 'User settings',
      'video_text1': 'Our introductory video ',
      'video_text2': 'Reinforcer video',
      'video_text3': 'Choices video',
      'video_text4': 'Bad choices video',
      'video_text5': 'Voice box video',
      'video_text6': 'Building vocabulary video',
      'video_text7': 'Creating folders video',
      'video_text8': 'Sentence structure – part one video',
      'video_text9': 'Sentence structure – part two video',
      'video_text10': 'Grammar and developed literacy video',
      'video_text11': 'Learning words video',
      'video_text12': 'Predictive images/writing video',
      'video_text13': 'User settings video',
      'showHelper_LevelSettings_title1': 'First:',
      'showHelper_LevelSettings_title2': 'Fill information',
      'showHelper_LevelSettings_title3': 'Change level',
      'showHelper_LevelSettings_title4': 'Learning screen',
      'showHelper_LevelSettings_text1':
          'Please read all the info we have provided for you',
      'showHelper_LevelSettings_text2':
          'Some levels require information from your side. They are clearly highlighted',
      'showHelper_LevelSettings_text3':
          'If you need to change levels, please do so by pressing this icon',
      'showHelper_LevelSettings_text4':
          'Once ready, go back to the Learn screen',
      'showHelper_image-settings_title1': 'Find',
      'showHelper_image-settings_title2': 'Edit',
      'showHelper_image-settings_title3': 'Grid size',
      'showHelper_image-settings_title4': 'Help',
      'showHelper_image-settings_text1':
          'Enter the text and press the button to find the images',
      'showHelper_image-settings_text2': 'Click on the image to edit it',
      'showHelper_image-settings_text3':
          'Change the grid size by pressing this button',
      'showHelper_image-settings_text4':
          'Toggle help on or off using this button',
      'showHelper_folders_title1': 'Click',
      'showHelper_folders_title2': 'Double click',
      'showHelper_folders_title3': 'Long press',
      'showHelper_folders_title4': 'Add',
      'showHelper_folders_title5': 'Back to parent folder',
      'showHelper_folders_text1': 'Click on an item to view its properties',
      'showHelper_folders_text2':
          'Double click on a folder to view its children',
      'showHelper_folders_text3': 'Long press an item to lock/unlock it',
      'showHelper_folders_text4': 'Add folders, images, sounds and videos',
      'showHelper_folders_text5':
          'To return to the parent folder press this icon',
      'Show Help Screens': 'Show Help Screens',
      'privacy policy': 'Privacy policy',
      'must accept privacy policy':
          'You must accept our privacy policy before continuing',
      'view privacy policy': 'View privacy policy',
      'accept privacy policy': 'Accept privacy policy',
      'show hide schedule': 'Show/hide schedule',
      'show hide stories and schedule':
          'Show or hide the stories and the schedule',
      'show': 'Show',
      'hide': 'Hide',
      'share item': 'Share',
      'check connection': 'Check connection',
      'not connected to internet':
          'Looks like you are not connected to Internet',
      'user information': 'User information',
      'settings restrictions instructions':
          'Access to the configuration can be restricted. This is useful if the user tries to click on the configuration icon distracting himself from the learning process. When the configuration restriction is enabled, the answer to a simple mathematical problem must be provided. If the answer is correct, access to the configuration section will be granted. This restriction mechanism allows parents and teachers to restrict access to the configuration section without the need to remember and share passwords.',
      'settings password protected': 'Settings restrictions',
      'settings password protected no': 'No restrictions',
      'settings password protected yes': 'Request math answer',
      'delete linked device': 'Delete linked device',
      'confirm delete linked device':
          'Do you want to delete the linked device? If you delete it, you will need to relink it later to add it back again.',
      'echo device': 'This device will echo the voicebox',
      'device silent': 'This device will remain silent',
      'device blocked': 'The device is now blocked.',
      'device unblocked': 'The device has been unblocked.',
      'output voicebox to device': 'Output voice box to another device',
      'quizzes': 'Quizzes',
      'quizzes instructions':
          'Quizzes can be created (as a teacher/educator) on this device (quizzes can be answered on any device)',
      'can create quiz': 'Can create quiz',
      'can not create quiz': 'Can not create quiz',
      'invite rejected': 'Invite rejected by',
      'invite sent': 'Invite sent to',
      'recieved invite': 'You have received an invitation to link with',
      'accept': 'Accept',
      'ignore and dismiss': 'Ignore and dismiss',
      'invite confirmed': 'Invite confirmed to',
      'invite accepted': 'Invite accepted by',
      'remember link other party':
          'Remember: repeat the same process on the other device.',
      'please enter remote email': 'Please enter the other party email',
      'add new device': 'Add new device',
      'remote user email': 'Remote user email',
      'remote user email instructions':
          'To create a link between two devices, make sure both devices are turned on, are connected to internet, have the APP running and are showing the linked devices screen (this screen). The link establishment must be executed on both devices (each device must enter the others party email)',
      'enter remote user email': 'Enter remote user email',
      'warning': 'Warning',
      'email or name not filled':
          'Email or name not filled. Please complete this information before trying to link new devices.',
      'email or name required for backup':
          'Email or name not filled. Please complete this information before trying to backup the device.',
      'email or name required for restore': 'Email is required to restore',
      'start restore': 'Start restore',
      'replace folder': 'Replace folder',
      'add to folder': 'Add to folder',
      'what to do with folder':
          'Select the local folder that will be replaced. It is suggested to backup this device before restoring any folder as the local folder\'s content will be deleted before replacing it with the remote folder.',
      'choose folder to restore': 'Choose folder to restore',
      'quiz': 'Quiz',
      'linked devices': 'Linked devices',
      'no linked devices': 'No linked devices where found',
      'change user name': 'Change user name',
      'confirm change user name': 'Do you want to change the user\'s name?',
      'user name': 'User name',
      'user name hint': 'Enter the user\'s name',
      'change user email': 'Change email',
      'confirm change user email':
          'If you change the user\'s email you will need to relink devices (the parent or the educator will need to recreate the link to this device). Do you want to continue?',
      'user email': 'User\'s email',
      'user email instructions':
          'Enter the email to be used by the user. It can be the parent\'s email if the user does not have one. Do not put the educator\'s or teacher\'s email in this field. The email is used to identify as unique each user. The email is used to link devices for syncing or quizzes.',
      'user email hint': 'Enter email',
      'toggle visibility for all': 'Change visibility of all concepts',
      'item availability': 'Item availability',
      'item availability instructions':
          'If an item is not available, you can indicate it. Non available items will be shown with a red X over the image',
      'is available': 'Is available',
      'is not available': 'Is not available',
      'not available': 'Not available',
      'available': 'Available',
      'delete story': 'Delete story',
      'confirm delete story': 'Are you sure you want to delete the story?',
      'level not enabled': 'Level not enabled',
      'not enough data':
          'Predictive writing is not enabled because not enough data has been gathered',
      'image size': 'Image size',
      'text size': 'Text size',
      'medium': 'Medium',
      'large': 'Large',
      'select video': 'Select video',
      'selected video': 'Selected video:',
      'recording': 'Recording...',
      'story object instructions':
          'You can dismiss concepts by swiping them. Nothing will be deleted. (concepts are only deleted in edit mode)',
      'edit story name': 'Edit story name',
      'select this concept': 'Select this concept',
      'no story object instructions': '',
      'add story object': 'Add concept',
      'story name hint': 'Enter story name',
      'create new story': 'Create a new story',
      'no stories instructions':
          'Stories allow you to join concepts (images, sounds and videos) to explain new ideas. For example, you can explain a visit to the zoo that begins by showering, putting on clothes, having breakfast, traveling by car and seeing the animals.',
      'add story': 'Add story',
      'please confirm': 'Please confirm',
      'replace sound confirmation':
          'Do you want to replace the existing audio?',
      'replace': 'Replace',
      'voiceBoxSize': 'Voice box size',
      'small': 'Small',
      'big': 'Big',
      'select sound': 'Record audio',
      'select sound instructions':
          'Record the sound you wish. This audio can be played back when the user clicks on the image.',
      'delete': 'Delete',
      'delete confirmation':
          'Please confirm that you wish to delete this object. This operation is irreversible.',
      'warning not user created':
          'WARNING: This object is bundled by default with the APP. If you delete it there is no way to recover it and you must manually add it with it\'s image and text in each language.',
      'folder not empty will not delete':
          'Folder must be empty before deleting',
      'local device': 'Device',
      'library': 'Library',
      'camara': 'Camera',
      'folder should talk': 'Say folder\'s name',
      'folder should talk instructions':
          'Enable if you want to hear the name of the folder when clicking on it.',
      'loading images': 'Loading images',
      'loading folders': 'Loading folders',
      'loading relations': 'Loading relations',
      'loading categories': 'Loading categories',
      'loading videos': 'Loading videos',
      'loading sounds': 'Loading sounds',
      'allowLongPressInLearningScreen':
          'Allow long pressing a concept in learning mode',
      'long press instructions':
          'In learning mode, if the user will long press a concept, a screen will be shown presenting detailed information of the selected option.',
      'Not assigned': 'Not assigned',
      'nothing unlocked': 'Nothing unlocked',
      'nothing unlocked instructions':
          'Before using this grid, you must select (show / unlock) the concepts you want. Lock / unlock the concepts by keeping them pressed. \n\nRemember that the folders are not shown in this level.',
      'please unlock':
          'Please unlock / make visible the items you want in Configuration, Folders',
      'default folder': 'Default folder',
      'open folders': 'Open folders',
      'default folder instructions':
          'To select this folder as the default folder, click the button',
      'edit': 'Edit',
      'unlock': 'Unlock',
      'lock': 'Lock',
      'understood': 'Understood',
      'not understood': 'Not understood',
      'is understood': 'Concept is understood',
      'is not understood': 'Concept is not yet understood',
      'conceptIsUnderstood': 'Concept understanding',
      'conceptIsUnderstoodInstructions':
          'Once the user has the clear concept, mark it as understood. This helps teachers and parents communicate. All the concepts understood are framed in green in the learning grid.',
      'object visible': 'Object is currently visible',
      'object not visible': 'Object is currently not visible',
      'visibility': 'Visibility',
      'visibility instructions':
          'Show or hide (unlock/lock) the images you desire',
      'image to show': 'Image to show',
      'text to show': 'Text to show',
      'text to show instructions':
          'This is the text shown under each image in the learning grid.',
      'text to show hint': 'Enter the text to show',
      'text to say': 'Text to say',
      'text to say instructions':
          'You can change what to say! Instead of saying "My name is ...", you can change it to "My name is [put the name here]" or "My sister is [sister\'s name]". It is also useful to have a short text to display but a long text to say, such as when an image represents a long phrase.',
      'text to say hint': 'Enter the text to say',
      'no default folder': 'Default folder not selected',
      'please select a default folder':
          'Select a default folder. Only the images you have unlocked from that folder will be shown.',
      'select folder': 'Select default folder',
      'select a folder': 'Select the remote folder you want to import',
      'current default folder': 'Current default folder:',
      'debug mode': 'Debug mode',
      'user profile': 'User settings',
      'add': 'Add',
      'Grid size': 'Grid size',
      'grid size instructions':
          'If you wish, you can change the size of the grid (columns and rows). Change this setting only if you have a device with a large screen. Verify that the user can see and touch each icon comfortably.',
      'operation completed successfully': 'Operation completed successfully',
      'restore device': 'Restore device',
      'user email to restore': 'User email to restore',
      'categories': 'Categories',
      'category': 'Category',
      'close': 'Close',
      'add folder': 'Add folder',
      'add image': 'Add image',
      'add empty': 'Add empty space',
      'add video': 'Add video',
      'add sound': 'Add sound',
      'new folder name': '',
      'new image name': '',
      'new video name': '',
      'new sound name': '',
      'show folder': 'Show folder',
      'hide folder': 'Hide folder',
      'delete folder': 'Delete folder',
      'folder instructions':
          'Click or double click an image or an empty space to activate it\'s options. Click on the menu to explore more options.',
      'grid instructions':
          'Depending of the needs of the user (for larger icons) or the size of the screen of the device, You can change the grid size of the images shown starting from level 5.',
      'grid': 'Grid',
      'Columns': 'Columns',
      'Rows': 'Rows',
      'folders': 'Folders',
      'level not found': 'Level not found',
      'missing reinforcer': 'Missing reinforcer',
      'confirm reinforcer': 'Please confirm you want to use ',
      'selected reinforcer': 'Your current selected reinforcer is:',
      'please select a reinforcer': 'Please select a reinforcer for this level',
      'cancel': 'Cancel',
      'learn': 'Learn',
      'stories': 'Stories',
      'schedule': 'Schedule',
      'help videos': 'Help videos',
      'images': 'Images',
      'colors': 'Colors',
      'amber': 'Amber',
      'blue': 'Blue',
      'cyan': 'Cyan',
      'deepOrange': 'Deep orange',
      'deepPurple': 'Deep purple',
      'green': 'Green',
      'indigo': 'Indigo',
      'lightBlue': 'Light blue',
      'lightGreen': 'Light green',
      'lime': 'Lime',
      'orange': 'Orange',
      'pink': 'Pink',
      'purple': 'Purple',
      'red': 'Red',
      'teal': 'Teal',
      'yellow': 'Yellow',
      'dark mode': 'Dark mode',
      'select this theme': 'Select this theme',
      'select voice': 'Select voice',
      'no voice selected':
          'No voice selected. If you do not select a voice, the APP will be silent.',
      'tts': 'Text to Speech',
      'voice speed': 'Voice speed',
      'say': 'Say out loud',
      'send by email': 'Send by email',
      'user name not configured': 'User name not configured',
      'change': 'Change',
      'no valid voice found': 'No valid voice was found',
      'test voice': 'Test voice. Click to activate.',
      'test text':
          'If you can hear this sentence then you have correctly configured the voice.',
      'settings title': 'Settings',
      'levels': 'Levels',
      'language': 'Language',
      'select language instructions': 'Select your preffered language',
      'Chinese': 'Chinese',
      'English': 'English',
      'Hindi': 'Hindi',
      'Spanish': 'Spanish',
      'Arabic': 'Arabic',
      'Malay': 'Malay',
      'Russian': 'Russian',
      'Bengali': 'Bengali',
      'Portuguese': 'Portuguese',
      'French': 'French',
      'German': 'German',
      'find image': 'Find image',
      'selected level': 'Selected level',
      'level1': 'Level 1',
      'level2': 'Level 2',
      'level3': 'Level 3',
      'level4': 'Level 4',
      'level5': 'Level 5',
      'level6': 'Level 6',
      'level7': 'Level 7',
      'level8': 'Level 8',
      'level9': 'Level 9',
      'level10': 'Level 10',
      'level11': 'Level 11',
      'change level': 'Change level',
      'summary': 'Summary',
      'level1 name': 'Reinforcer',
      'level1 summary':
          'The primary function of this level is to motivate the user to touch the screen. The learning outcome is achieved when the user touches the screen independently to request one object.',
      'Who does this level cater for': 'Who does this level cater for?',
      'level1 Who does this level cater for':
          'A child or adult with limited, to zero communication. The primary function of this level is to encourage the user to be motivated by the APP/device',
      'How do we achieve this?': 'How do we achieve this?',
      'level1 How do we achieve this':
          'The parent/teacher/specialist must be aware of the child\'s reinforcer. A reinforcer is an object or item that the user enjoys or is obssesed with. A good example of this would be a food item, such as chocolate.',
      'select reinforcer': 'Select reinforcer',
      'How do we get the user to touch the screen?':
          'How do we get the user to touch the screen?',
      'level1 How do we get the user to touch the screen':
          'Level 1 is set up as one screen/button that speaks as soon as it is touched. Using the example of chocolate, a parent/teacher/specialist should set up the app to show the chocolate image. The parent/teacher/specialist MUST be prepared during every teaching session by having many small pieces of chocolate that can provide an instant reward to the user. Remember, it is important to set aside time for the teaching sessions, but every moment of the day can be a teaching opportunity. Have the iPad in a place where the User can have every opportunity to use it. \n\nDuring your teaching session\n1.	Offer a small piece of chocolate to the user. It is best to have the User seated, although this may not always be possible.\n2.	Use ‘hand over hand’ to encourage the User to touch the screen. ‘Hand over hand’ is a teaching approach used with autistic children. The parent/teacher/specialist assists the User by encouraging him/her to press the button. The parent/teacher/specialist places their hand over the User’s hand and directs them towards the selected button.*\n3.	As soon as the APP speaks, the parent/teacher/specialist must instantly give the chocolate to the User.\n4.	This should be repeated regularly for a period of up to 5 minutes unless the User becomes frustrated. Do not provide the User with chocolate until the button has been pressed, regardless of how frustrated they are.\n5.	If the User becomes frustrated, do not give up. This is a long process, but the long- term gains will set the User up for life. Stop and revisit this task when the User is calm.\n\nRepeat steps 1-5 at regular intervals throughout the day. Many Users will be very quick to succeed at this level and others will take a lot of hard work, patience and effort.\n\n*The force of this assistance should be gradually reduced. This may take months to remove fully.',
      'How do you know ready for level 2':
          'How do you know the user is ready for level 2?',
      'level1 How do you know ready for level 2':
          'The user will reduce the need for "hand over hand" as you notice that your child starts to understand this APP helps them to get their reinforcer. When the user is pushing the button independently and consistently, without any support from the parent/teacher, the user is ready for level 2',
      'level2 name': 'Choices',
      'level2 summary':
          'This level is designed to teach the User that there is more than one option for a rewarding outcome. \n\nLearning outcome: The User will have the ability to request both items consistently and with understanding.',
      'level2 Who does this level cater for':
          'This level caters for Users who have accessed level 1 and have minimal need for ‘hand over hand’. The User progresses by being offered two options which encourage them to make a choice.',
      'level2 How do we achieve this':
          'The parent/teacher/specialist must ensure that the second image being added to the screen is a second reinforcer, for example, juice. \n\nThe User will now have the option to request two of their favourite items and this will build their relationship with the app.',
      'select second reinforcer': 'Select second reinforcer',
      'level2 How do we get the user to touch the screen':
          'The parent/teacher/specialist will use the same strategies employed in Level 1. In summary, the two items must be readily available and provided to the User as soon as requested. \n\nIt is important to ensure that the User is getting the correct item and is aware of the difference in the two images. The User should be shown one of the items and must request this accurately and consistently. Data will be available to highlight responses and show accuracy. \n\nThis level is one of the fastest levels to progress through as the User should already be motivated by the level 1 reinforcer.',
      'How do you know ready for level 3':
          'How do you know the user is ready for level 3?',
      'level2 How do you know ready for level 3':
          'The User will show improved confidence in using the App independently and there should be limited need for ‘hand over hand’. \n\nWhen the User is pushing the buttons independently and consistently, with limited support from the parent/teacher/specialist, this is a sign that the User is ready for level 3. ',
      'level3 name': 'Bad choices',
      'level3 summary':
          'At this stage the User will be understanding that the App provides an outcome that gives him/her pleasure. It is important that this level is provided as this progression teaches the User that all choices are not rewarding but they are communication. This level is achieved in a short period of time. \n\nLearning outcome: The User should be observed to show distaste with receiving the non-preferred option. The User will no longer choose this option.',
      'level3 Who does this level cater for':
          'This level caters for Users who have accessed levels 1 and 2 and have minimal/zero need for ‘hand over hand’. The User progresses by being offered a third option which is not a favorable choice.',
      'level3 How do we achieve this':
          'At this stage of development, the User will now have a non-preferred option. The parent/teacher/specialist must ensure that the third image being added to the screen is non-preferred item, for example, a sock. \n\nThe User will now have the option to request two preferred options and a non-preferred option.',
      'select third reinforcer': 'Select third word',
      'level3 How do we get the user to touch the screen':
          'The User should now be motivated by the App and will be intrigued to touch the images. They have received pleasure from the images to date. The User will be inquisitive and should wish to receive a positive outcome from the non-preferred item. She/he should be motivated without stimulus from the parent/teacher/specialist however, if this is not the case then the parent/teacher/specialist should follow strategies from Level 1 to encourage this interaction.\n\nIf the User selects/touches any of the three images, they will receive the item instantly. The first three levels are designed to teach the user how to request an item. This level consolidates the fact that not all choices are pleasurable but they are requests. The User will now be learning to consider that images they touch will be items that they receive, regardless if they like them or not.',
      'How do you know ready for level 4':
          'How do you know the user is ready for level 4?',
      'level3 How do you know ready for level 4':
          'The User will show disappointment when receiving the non-preferred item and will continue to be pleased with other items requested. The parent/teacher/specialist should continue to observe improved confidence in using the App independently. \n\nWhen the User is pushing the buttons independently and consistently, without any support from the parent/teacher/specialist, the User is ready for level 4. Data will prove these observations. The User should also be observed to show distaste with receiving the non-preferred option. The User will no longer choose this option.',
      'level4 name': 'Voice box',
      'level4 summary':
          'This level is designed to start building the language structure that will be used in the next levels. The reward for the User will only be given once he/she selects the image and touches on the voice box.\n\Learning outcome: The user will select a chosen item and will understand that the item will not be provided until she/he touches the voice box.',
      'level4 Who does this level cater for':
          'This level caters for Users who have accessed levels 1-3 and are now using the App independently with minimal/zero ‘hand over hand’ support. \n\nThis level is one of the more challenging levels for the parent/teacher/specialist and frustrating levels for the User. The aim of this level is to teach the User to use a voice box which allows for language development. At this stage, the parent/teacher/specialist is planning to develop language by preparing the User to use two-word level ie. want chocolate. This level takes time and patience. It may require reverting back to ‘hand over hand’ for a short time.',
      'level4 How do we achieve this':
          'At this stage, the level 3 screen remains with the same three options although the screen now has a long strip at the top of the screen. This strip is referred to as the ‘voice box’. When the User touches the usual images, the word will no longer be spoken immediately. It will now be displayed in the voice box at the top of the screen. The User must now touch the voice box in order to enable the selected words to be spoken.',
      'level4 How do we get the user to touch the screen':
          'The User will no longer receive instant gratification when the item is requested. She/he must be encouraged to touch the voice box. This will require ‘hand over hand’ to initially teach the User and show what is expected. All Users will learn this at a different rate. The parent/teacher/specialist should gradually reduce the ‘hand over hand’ depending on the understanding of the User.',
      'How do you know ready for level 5':
          'How do you know the user is ready for level 5?',
      'level4 How do you know ready for level 5':
          'The User will independently, or with ‘hand over hand’ support, select the item and touch the voice box. Data will show a high percentage success rate.',
      'level5 name': 'Building vocabulary',
      'level 5 folders': 'Behaviour of folders',
      'level 5 folder info':
          'In the learning screen, only the selected folder is shown. The folder bar that allows to navigate between folders in not shown. This is intentional so the user will not navigate into other folders and distract from the level\'s objective',
      'level5 summary':
          'This level is the start of the teaching process with the primary aim being to build language for the User.\n\nLearning outcome: The User will have a clear understanding of 6 or more words within one folder.',
      'level5 Who does this level cater for':
          'This level caters for Users who have accessed Levels 1-4. Users will generally be using the App independently at this stage although some may require ‘hand over hand’ support. \n\nThis level is the start of the teaching process with the primary aim being to build language for the User. The parent/teacher/specialist role becomes more important at this stage as new words should now be introduced to the User, and the parent/teacher/specialist must select words that would be important to the User. The words must also be within the same category ie. using the example of chocolate would require building language for snack items, and the snack items must be those preferred by the User. The categories have been pre-arranged into folders and the words can be made visible as required. If the words/items are not currently available on the folder, the parent/teacher/specialist can take a photo and add them in.\n\nAt this stage, the parent/teacher/specialist must follow the guidance that is provided in the teaching section regarding the use of videos, cards and items. This level takes time and a lot of patience. ‘Hand over hand’ may continue until the User builds his/her confidence.',
      'level5 How do we achieve this':
          'The Parent/Teacher/Specialist section within the App provides detail on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. \n\nThis section includes:\n1.	Continuing to request items\n2.	Matching pictures\n3.	Matching picture to object\n4.	Matching picture to item',
      'level5 How do we get the user to touch the screen':
          'This level requires the User to focus and remain seated to improve communication and build vocabulary. It is unlikely that the User will be willing to engage and therefore it is essential that the main reinforcer is re-introduced. The main reinforcer discussed as an example in the previous summaries was chocolate. In this case the chocolate must be readily available throughout these sessions as the User will be motivated to work if they are provided with a reward. \n\nInitially, the User should be rewarded with their reinforcer after EVERY successful item has been requested ie. when matching every item, the User should be rewarded with a small treat such as a third of a chocolate button. Gradually reduce the reinforcer treat as the User becomes more confident. In time, the User will no longer require a reinforcer. \n\For many this may require ‘hand over hand’ to initially teach the User and show what is expected. All Users will learn this at a different rate. The parent/teacher/specialist should gradually reduce the ‘hand over hand’ depending on the understanding of the User.',
      'How do you know ready for level 6':
          'How do you know the user is ready for level 6?',
      'level5 How do you know ready for level 6':
          'The User will have developed words within this category ie. snacks. This category will continue to be known as the ‘snack’ folder. When a folder contains 6 or more items the User is ready to progress to Level 6. The User would be expected to select items independently although some Users may still prefer ‘hand over hand’ support at this time. Data will continue to be available to show a high percentage success rate in identifying the chosen items. ',
      'level6 name': 'Creating folders',
      'level6 summary':
          'This Level allows Users to develop their language by increasing folders. Folders are created to allow Users to compartmentalize different topics ie. food, transport, clothes. \n\nLearning outcome: The User will show confidence in selecting items. They will be able to move between a minimum of three folders with ease.',
      'level6 Who does this level cater for':
          'This level differs from the others in that it caters for two groups:\n1.	Users who have accessed levels 1-5. These Users will be developing in confidence and most will be using the App independently. Some Users may still require extra support with ‘hand over hand’. Do not discourage this as all Users will develop at a different rate – as confidence grows, the need for support will reduce. \n2.	This would be the suggested stage to introduce the App to Users with limited/zero communication who are visual learners with moderate to good understanding. The parent/teacher/specialist should familiarize themselves with the teaching strategies employed in Levels 1-5 to promote maximum progress and understanding.\n\nThis Level allows Users to develop their language by increasing folders. Folders are created to allow Users to compartmentalize different topics ie. food, transport, clothes. \n\nThe Users who have accessed Levels 1-5 should be engaged and have a clear understanding of what is expected of them. This level allows the parent/teacher/specialist to add different folders to increase the language/speech opportunities. Consider this level as being similar language development for any individual learning a new language. Typical language development starts with one word ie. juice, cat, car. The words come from different folders. We, at Lucas Education, have created a template of folders that we believe are essential for day-to-day communication.',
      'level6 How do we achieve this':
          'One additional folder will be made available to the existing folder in Level 5. For new Users, two folders will be available. The parent/teacher/specialist selects a second folder which contains items that are motivating to the User. When data shows that the User has clearly understood 5 words, the App with allow the opportunity to unlock 5 more words within this folder as well as another folder. \n\nThis process will continue as your User continues to develop and grow. This is a natural process and the same process that all individuals go through when learning to speak and communicate. Level 6 is on-going learning and development.   \n\nThe Parent/Teacher/Specialist section within the App provides further detail on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. Games will be available in due course.\n\nThis section includes:\n1.	Continuing to request items\n2.	Matching pictures\n3.	Matching picture to object\n4.	Matching picture to item',
      'level6 How do we get the user to touch the screen':
          'This Level continues to require the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the program on the move. Examples of such opportunities are when seated in the car or maybe your child enjoys sitting in their pram.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be motivated to work if they are provided with a reward. It is important however to reduce the frequency of the reward. As the language develops, the reinforcer should be reduced and removed.  \n\nThis may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication.',
      'How do you know ready for level 7':
          'How do you know the user is ready for level 7?',
      'level6 How do you know ready for level 7':
          'The User will show confidence in selecting items. They will be able to move between a minimum of three folders with ease. Data will continue to be available to show a high percentage success rate in identifying the chosen items.',
      'level7 name': 'Sentence structure – part one',
      'level7 summary':
          'This Level allows Users to develop sentence structure by introducing a sentence starter. Folders are predesigned to predict possible sentence starters for each folder. \n\nLearning outcome: The User will show confidence in selecting the sentence starter followed by the chosen item. The words will be activated by pressing the voicebox.',
      'level7 Who does this level cater for':
          'This level caters for Users who have accessed Level 6.\n\nThis Level allows Users to develop sentence structure by introducing a sentence starter. Folders are predesigned to predict possible sentence starters for each folder. The option is also available to personalise words.',
      'level7 How do we achieve this':
          'In the previous section, typical language development was discussed. This section takes language development to the next level. Children move from one word level to two. We, at Lucas Education achieve this by introducing sentence starters which vary depending on the folder. Examples of this would be as follows:\n1.	Food folder – I want chocolate……I do not want chocolate.\n2.	Animal folder – I hear cat\n3.	Transport folder – I see car.\n\nSimilar to Level 4, the User may become frustrated during the initial stages of this Level as they are now expected to include a word prior to what has been expected of them in previous levels. For many reinforcers must be introduced again to ensure that the User remains motivated. \n\nAs with the previous folder the words/images will be released when data proves that the User is capable of understanding and consistently includes the sentence starter before requests. Level 7 is on-going learning and development.   \n\nThe Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources.',
      'level7 How do we get the user to touch the screen':
          'This Level also requires the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the programme on the move. Examples of such opportunities are when seated in the car or maybe your child enjoys sitting in their pram.\n\nOnce both icons, namely the sentence starter and the requested item, are appearing in the voice box, the User must touch the voice box and the App will say the sentence for example “I want chocolate” At this point the parent/teacher will give the User what he/she is requesting. The voice box should not be activated until an action and an image are added. Both icons must be spoken in the one voice box; they cannot be selected and spoken independently.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be more motivated to work if they are provided with a reward. This may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication. ',
      'How do you know ready for level 8':
          'How do you know the user is ready for level 8?',
      'level7 How do you know ready for level 8':
          'The User will show confidence in selecting the sentence starter followed by the chosen item. Data will continue to be available to show a high percentage success rate in identifying the chosen items and more sentence starters will be unlocked to develop language further.',
      'level8 name': 'Sentence structure – part two',
      'level8 summary':
          'This level caters for Users who have accessed Level 7.\n\nThis Level allows Users to develop sentence structure by including a sentence closer. Folders are predesigned to predict possible sentence closers for each folder. The option is also available to personalise words.',
      'level8 Who does this level cater for':
          'This level caters for Users who have accessed Level 7.\n\nThis Level allows Users to develop sentence structure by including a sentence closer. Folders are predesigned to predict possible sentence closers for each folder. The option is also available to personalise words.',
      'level8 How do we achieve this':
          'In Level 5, typical language development was promoted and in Level 6 the sentence starters were added. This Level progresses language development to the next level by closing the sentences. We, at Lucas Education achieve this by providing predicted sentence closers which vary depending on the folder. Examples of this would be as follows:\n1.	Food folder – I want chocolate please\n2.	Animal folder – I hear cat\n3.	Transport folder – I see car.\n\nThe final part of the sentences can or cannot be used in conjunction with the action and objects. For example in some cases, the closing part can be used alone eg. All done!\n\nSimilar to Levels 4 and 7, the User may become a little frustrated during the initial stages of this Level as they are now expected to include a word following what has been expected of them in previous levels. For many, reinforcers must be introduced again to ensure that the User remains motivated. \n\nAs with the previous folder the words/images will be released when data proves that the User is capable of understanding and consistently includes the sentence closer after requests. Level 8 is on-going learning and development.\n\The Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. ',
      'level8 How do we get the user to touch the screen':
          'This Level also requires the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the programme on the move. Such opportunities could be made possible at snack time or perhaps when ordering food at a takeaway.\n\nWhen all three icons, namely the sentence starter, the requested item and the sentence closer, are appearing in the voice box, the User must touch the voice box and the App will say the sentence, for example “I want chocolate, please!”. At this point the parent/teacher will give the person what she/he is requesting. The voice box should not be activated until an action, an image and a closer are added. All three icons must be spoken in the one voice box; they cannot be selected and spoken independently.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be more motivated to work if they are provided with a reward. This may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication.',
      'How do you know ready for level 9':
          'How do you know the user is ready for level 9?',
      'level8 How do you know ready for level 9':
          'The User will show confidence in selecting the sentence starter followed by the chosen item and sentence closer. Data will continue to be available to show a high percentage success rate in identifying the chosen items and more sentence closers will be unlocked to develop language further. \n\nUsers at this Level are now capable of accessing Levels 9, 10 and 11. All three Levels are challenging and cater for higher functioning Users. These Levels do not have to taught in a sequential order, for example, the User may find difficulty in progressing through Levels 9 and 10, but may succeed in Level 11.',
      'level9 name': 'Grammar and developed literacy',
      'level9 summary':
          'This Level allows higher functioning Users the opportunity to focus on building sentence structure by developing literacy through use of conjunctions, connectives and pronouns.\nThis is an important building block to teaching the User how to read. \n\nTHIS IS ONE OF THE MORE CHALLENGING LEVELS.\n\nLearning outcome: The User will have the ability to communicate with confidence by linking words with conjunctives and using other literacy cues to develop language further.',
      'level9 Who does this level cater for':
          'This level caters for Users who have accessed Level 8.\n\nThis Level allows higher functioning Users the opportunity to focus on building sentence structure by developing literacy through use of conjunctions, connectives and pronouns.\n\nTHIS IS ONE OF THE MORE CHALLENGING LEVELS.',
      'level9 How do we achieve this':
          'The Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. \n\nData will also assist in gathering success criteria and in unlocking progressive language.',
      'level9 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program. ',
      'How do you know ready for level 10':
          'How do you know the user is ready for level 10?',
      'level9 How do you know ready for level 10':
          'The User is capable to access Level 10 directly from Level 8. All Levels can be used at the same time to develop language. Words will be unlocked when data dictates that the User is ready. ',
      'level10 name': 'Learning words',
      'level10 summary':
          'This Level allows higher functioning Users the opportunity to focus on learning words as opposed to pictures. This Level progresses by removing pictures and replacing them with the name/text of each object. This is the initial step in providing our non-verbal children with the opportunity to read.\n\nLearning outcome: The User will have the ability to communicate with the same confidence by using words as opposed to images.',
      'level10 Who does this level cater for':
          'This level caters for Users who have accessed Level 8 or 9.\n\nThis Level allows higher functioning Users the opportunity to focus on learning words as opposed to pictures. Users who require images should bypass this Level and access Level 10.',
      'level10 How do we achieve this':
          'The Parent/Teacher/Specialist will have an understanding of the favourite words selected by the User. Data will also assist in gathering such details. All words have been set up to show a large image with a small defined word below (show example). The Parent/Teacher/Specialist will now gradually reduce the size of the picture for the favourite words, whilst increasing the size of the word. With time the Parent/Teacher/Specialist will aim to remove the image and only provide the User with the word. Once again, experience and data will provide feedback on the understanding of the User and their readiness to remove images from other buttons.',
      'level10 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program. If they are unable to use the words when the images have been reduced, this is a sign that the User is not ready for this Level and it must be revisited at another stage.',
      'How do you know ready for level 11':
          'How do you know the user is ready for level 11?',
      'level10 How do you know ready for level 11':
          'The User will show confidence in selecting icons with words as opposed to images. Data will continue to be available to show a high percentage success rate in identifying the chosen items.',
      'level11 name': 'Predictive images/writing',
      'level11 summary':
          'This Level allows Users the opportunity to communicate with greater speed by providing the User with the opportunity to select predicted images or words. \n\nLearning outcome: The User will have the ability to communicate with the same confidence although at a greater speed and fluency.',
      'level11 Who does this level cater for':
          'This level caters for Users who have accessed Level 8.\n\nThis Level allows Users the opportunity to communicate with greater speed. ',
      'level11 How do we achieve this':
          'This Level provides the User with the opportunity to select predicted images or words. The App will provide a list of actions to be selected by the user. Once an action is selected, the pictures/words to be shown will be presented depending on the frequency of usage for each word. The most used words will appear higher in the grid while less used words for that specific action will appear lower on the grid.',
      'level11 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program',
    },
    // Hindi (544 million)
    'hi': {
      'app title': 'LUCAS',
      'relation': 'रिश्ता',
      'schedule day': 'अनुसूची दिन ',
      'sound': 'ध्वनि',
      'video': 'वीडियो',
      'story object': 'कहानी वस्तु',
      'translation': 'अनुवाद',
      'start': 'बैकअप आरंभ करो',
      'backup device': 'इस डिवाइस का बैकअप लें',
      'Minimum level to show': 'दिखाने के लिए न्यूनतम स्तर',
      'background color': 'पीछे का रंग',
      'loading empty spaces': 'खाली स्थान लोड हो रहा है',
      'loading translations': 'अनुवाद लोड कर रहा है',
      'Drag and drop enabled': 'खींचें और ड्रॉप सक्षम',
      'Drag and drop disabled': 'खींचें और अक्षम करें',
      'about this app': 'इस ऐप के बारे में',
      'text to find': 'खोज',
      'text to find instructions':
          'प्रश्न में खोजने के लिए शब्द या शब्द का हिस्सा दर्ज करें। सभी को खोजने के लिए खाली छोड़ दें।',
      'number of concepts': 'अवधारणाओं की संख्या',
      'one concept': 'एक अवधारणा',
      'two concepts': 'दो अवधारणाएँ',
      'three or more': 'तीन या अधिक अवधारणाएँ',
      'students': 'छात्र',
      'find results': 'परिणाम खोजें',
      'result is correct': 'रिजल्ट सही है',
      'result is wrong': 'परिणाम गलत है',
      'play quiz': 'प्रश्नोत्तरी सुनें',
      'silent quiz ongoing': 'मौन प्रश्नोत्तरी चल रही है',
      'send to device': 'भेजना:',
      'quiz type': 'प्रश्नोत्तरी का प्रकार',
      'quiz show image': 'चित्र दिखाओ',
      'quiz sound image': 'अवधारणाओं का उच्चारण करें',
      'quiz show sound and image': 'अवधारणाओं का उच्चारण करें और चित्र दिखाएं',
      'quiz do not show anything': 'कुछ दिखा नहीं',
      'send quiz': 'प्रश्नोत्तरी भेजें',
      'schedule_title1': 'स्वागत हे',
      'schedule_title2': 'दिन का समय',
      'schedule_title3': 'संपादन मोड',
      'schedule_title4': 'संपादन मोड',
      'schedule_title5': 'दिनों का प्रबंधन करें',
      'schedule_text1':
          'अनुसूची उन चीजों की कल्पना करने की अनुमति देती है जो घटित होंगी। यह आपके उपयोगकर्ता को यह समझने की अनुमति देता है कि वह आज और भविष्य में क्या करेगा। इसे बड़ा देखने के लिए आप किसी आइटम को लंबे समय तक दबा सकते हैं।',
      'schedule_text2': 'दिन के समय को छुपाना / दिखाना प्रत्येक गतिविधि होगी।',
      'schedule_text3':
          'संपादन मोड अवधारणाओं को प्रबंधित करने की अनुमति देता है। संपादन मोड में सभी दिन दिखाए जाएंगे और आप इसके साथ बातचीत करने के लिए प्रत्येक ऑब्जेक्ट पर क्लिक कर सकते हैं।',
      'schedule_text4':
          'उस दिन / समय और छवि का चयन करें जिसे आप दिखाना चाहते हैं।',
      'schedule_text5':
          'यदि आपको नए दिन जोड़ने की आवश्यकता है, तो यहां क्लिक करें।',
      'existing concept':
          'उसी दिन और घंटे के लिए पहले से ही एक अवधारणा है। कृपया सही करें और पुनः प्रयास करें।',
      'please select an object': 'कृपया किसी ऑब्जेक्ट का चयन करें',
      'please select a day': 'कृपया एक दिन का चयन करें',
      'select an object': 'किसी वस्तु का चयन करें',
      'add object': 'ऑब्जेक्ट को शेड्यूल में जोड़ें',
      'select day': 'दिन का चयन करें',
      'selected day': 'चयनित दिन',
      'select hour': 'घंटे का चयन करें',
      'monday': 'सोमवार',
      'tuesday': 'मंगलवार',
      'wednesday': 'बुधवार',
      'thursday': 'गुरूवार',
      'friday': 'शुक्रवार',
      'saturday': 'शनिवार',
      'sunday': 'रविवार',
      'school': 'स्कूल',
      'home': 'घर',
      'today': 'आज',
      'tomorrow': 'आने वाला कल',
      'no action required title': 'कोई कार्रवाई की आवश्यकता नहीं है',
      'no action required info':
          'कृपया प्रदान की गई जानकारी पढ़ें और जानें आइकन पर क्लिक करके जारी रखें',
      'reset': 'रीसेट',
      'video_title1': 'परिचयात्मक वीडियो',
      'video_title2': 'स्तर 1',
      'video_title3': 'लेवल 2',
      'video_title4': 'स्तर 3',
      'video_title5': 'स्तर 4',
      'video_title6': 'स्तर 5',
      'video_title7': 'स्तर 6',
      'video_title8': 'स्तर 7',
      'video_title9': 'स्तर 8',
      'video_title10': 'स्तर 9',
      'video_title11': 'स्तर 10',
      'video_title12': 'स्तर 11',
      'video_title13': 'उपयोगकर्ता सेटिंग',
      'video_text1': 'हमारा परिचयात्मक वीडियो',
      'video_text2': 'Reinforcer वीडियो',
      'video_text3': 'विकल्प वीडियो',
      'video_text4': 'बुरा विकल्प वीडियो',
      'video_text5': 'आवाज बॉक्स वीडियो',
      'video_text6': 'शब्दावली वीडियो का निर्माण',
      'video_text7': 'फ़ोल्डर वीडियो बनाना',
      'video_text8': 'वाक्य संरचना - भाग एक वीडियो',
      'video_text9': 'वाक्य संरचना - भाग दो वीडियो',
      'video_text10': 'व्याकरण और विकसित साक्षरता वीडियो',
      'video_text11': 'शब्द वीडियो सीखना',
      'video_text12': 'भविष्य कहनेवाला चित्र / वीडियो लेखन',
      'video_text13': 'उपयोगकर्ता सेटिंग्स वीडियो',
      'showHelper_LevelSettings_title1': 'प्रथम:',
      'showHelper_LevelSettings_title2': 'जानकारी भरें',
      'showHelper_LevelSettings_title3': 'स्तर बदलें',
      'showHelper_LevelSettings_title4': 'सीखने की स्क्रीन',
      'showHelper_LevelSettings_text1':
          'कृपया आपके लिए हमारे द्वारा प्रदान की गई सभी जानकारी पढ़ें',
      'showHelper_LevelSettings_text2':
          'कुछ स्तरों के लिए आपकी ओर से जानकारी की आवश्यकता होती है। उन्हें स्पष्ट रूप से उजागर किया गया है',
      'showHelper_LevelSettings_text3':
          'यदि आपको स्तर बदलने की आवश्यकता है, तो कृपया इस आइकन को दबाकर ऐसा करें',
      'showHelper_LevelSettings_text4':
          'एक बार तैयार होने के बाद, जानें स्क्रीन पर वापस जाएं',
      'showHelper_image-settings_title1': 'खोज',
      'showHelper_image-settings_title2': 'संपादित करें',
      'showHelper_image-settings_title3': 'ग्रिड आकार',
      'showHelper_image-settings_title4': 'मदद',
      'showHelper_image-settings_text1':
          'पाठ दर्ज करें और छवियों को खोजने के लिए बटन दबाएं',
      'showHelper_image-settings_text2':
          'इसे संपादित करने के लिए चित्र पर क्लिक करें',
      'showHelper_image-settings_text3': 'इस बटन को दबाकर ग्रिड का आकार बदलें',
      'showHelper_image-settings_text4':
          'इस बटन का उपयोग कर चालू या बंद टॉगल करें',
      'showHelper_folders_title1': 'क्लिक करें',
      'showHelper_folders_title2': 'डबल क्लिक करें',
      'showHelper_folders_title3': 'देर तक दबाना',
      'showHelper_folders_title4': 'जोड़ना',
      'showHelper_folders_title5': 'वापस मूल फ़ोल्डर में',
      'showHelper_folders_text1':
          'इसके गुणों को देखने के लिए किसी आइटम पर क्लिक करें',
      'showHelper_folders_text2':
          'अपने बच्चों को देखने के लिए एक फ़ोल्डर पर डबल क्लिक करें',
      'showHelper_folders_text3':
          'किसी आइटम को लॉक / अनलॉक करने के लिए उसे लंबे समय तक दबाएं',
      'showHelper_folders_text4': 'फ़ोल्डर, चित्र, ध्वनि और वीडियो जोड़ें',
      'showHelper_folders_text5':
          'मूल फ़ोल्डर में लौटने के लिए इस आइकन को दबाएं',
      'Show Help Screens': 'मदद स्क्रीन दिखाएँ',
      'privacy policy': 'गोपनीयता नीति',
      'must accept privacy policy':
          'जारी रखने से पहले आपको हमारी गोपनीयता नीति को स्वीकार करना चाहिए',
      'view privacy policy': 'गोपनीयता नीति देखें',
      'accept privacy policy': 'गोपनीयता नीति स्वीकार करें',
      'show hide schedule': 'कार्यक्रम दिखाएँ / छिपाएँ',
      'show hide stories and schedule':
          'कहानियों और कार्यक्रम को दिखाना या छिपाना',
      'show': 'प्रदर्शन',
      'hide': 'छिपाना',
      'share item': 'शेयर',
      'check connection': 'कनेक्शन की जाँच करें',
      'not connected to internet': 'लगता है कि आप इंटरनेट से नहीं जुड़े हैं',
      'user information': 'उपयोगकर्ता के लिए जानकारी',
      'settings restrictions instructions':
          'कॉन्फ़िगरेशन तक पहुंच प्रतिबंधित हो सकती है। यह उपयोगी है अगर उपयोगकर्ता कॉन्फ़िगरेशन आइकन पर क्लिक करने की कोशिश करता है जो सीखने की प्रक्रिया से खुद को विचलित करता है। जब कॉन्फ़िगरेशन प्रतिबंध सक्षम होता है, तो एक सरल गणितीय समस्या का उत्तर प्रदान किया जाना चाहिए। यदि उत्तर सही है, तो कॉन्फ़िगरेशन अनुभाग तक पहुंच दी जाएगी। यह प्रतिबंध तंत्र माता-पिता और शिक्षकों को पासवर्ड को याद रखने और साझा करने की आवश्यकता के बिना कॉन्फ़िगरेशन अनुभाग तक पहुंच को प्रतिबंधित करने की अनुमति देता है।',
      'settings password protected': 'सेटिंग्स प्रतिबंध',
      'settings password protected no': 'कोई पाबन्दी नहीं',
      'settings password protected yes': 'गणित उत्तर का अनुरोध करें',
      'delete linked device': 'लिंक किए गए डिवाइस को हटाएं',
      'confirm delete linked device':
          'क्या आप लिंक किए गए डिवाइस को हटाना चाहते हैं? यदि आप इसे हटाते हैं, तो आपको इसे फिर से जोड़ने के लिए बाद में इसे वापस relink करने की आवश्यकता होगी।',
      'echo device': 'यह डिवाइस वॉइसबॉक्स को इको करेगा',
      'device silent': 'यह उपकरण मौन रहेगा',
      'device blocked': 'डिवाइस अब अवरुद्ध है।',
      'device unblocked': 'डिवाइस को अनब्लॉक कर दिया गया है।',
      'output voicebox to device': 'दूसरे डिवाइस में आउटपुट वॉयस बॉक्स',
      'quizzes': 'क्विज़',
      'quizzes instructions':
          'इस डिवाइस पर क्विज़ बनाया जा सकता है (शिक्षक / शिक्षक के रूप में) (किसी भी डिवाइस पर क्विज़ का उत्तर दिया जा सकता है)',
      'can create quiz': 'प्रश्नोत्तरी बना सकते हैं',
      'can not create quiz': 'क्विज़ नहीं बना सकते',
      'invite rejected': 'द्वारा आमंत्रित किया गया',
      'invite sent': 'को आमंत्रित किया है',
      'recieved invite': 'के साथ लिंक करने के लिए आपको निमंत्रण मिला है',
      'accept': 'स्वीकार करना',
      'ignore and dismiss': 'नजरअंदाज करें और खारिज करें',
      'invite confirmed': 'को आमंत्रित किया',
      'invite accepted': 'द्वारा आमंत्रित किया गया',
      'remember link other party':
          'याद रखें: अन्य डिवाइस पर भी यही प्रक्रिया दोहराएं।',
      'please enter remote email': 'कृपया अन्य पार्टी ईमेल दर्ज करें',
      'add new device': 'नया डिवाइस जोड़ें',
      'remote user email': 'दूरस्थ उपयोगकर्ता ईमेल',
      'remote user email instructions':
          'दो उपकरणों के बीच एक लिंक बनाने के लिए, सुनिश्चित करें कि दोनों डिवाइस चालू हैं, इंटरनेट से जुड़े हैं, एपीपी चल रहा है और लिंक किए गए डिवाइस स्क्रीन (यह स्क्रीन) दिखा रहे हैं। लिंक स्थापना को दोनों उपकरणों पर निष्पादित किया जाना चाहिए (प्रत्येक डिवाइस को अन्य पार्टी ईमेल दर्ज करना होगा)',
      'enter remote user email': 'दूरस्थ उपयोगकर्ता ईमेल दर्ज करें',
      'warning': 'चेतावनी',
      'email or name not filled':
          'ईमेल या नाम नहीं भरा। नए उपकरणों को लिंक करने का प्रयास करने से पहले कृपया इस जानकारी को पूरा करें।',
      'email or name required for backup':
          'ईमेल या नाम नहीं भरा। डिवाइस का बैकअप लेने से पहले कृपया इस जानकारी को पूरा करें।',
      'email or name required for restore':
          'पुनर्स्थापित करने के लिए ईमेल आवश्यक है',
      'start restore': 'पुनर्स्थापित करना शुरू करें',
      'replace folder': 'फ़ोल्डर बदलें',
      'add to folder': 'फ़ोल्डर में जोड़ें',
      'what to do with folder':
          'उस स्थानीय फ़ोल्डर का चयन करें जिसे प्रतिस्थापित किया जाएगा। किसी भी फ़ोल्डर को पुनर्स्थापित करने से पहले इस डिवाइस को बैकअप करने का सुझाव दिया जाता है क्योंकि रिमोट फ़ोल्डर के साथ इसे बदलने से पहले स्थानीय फ़ोल्डर की सामग्री को हटा दिया जाएगा।',
      'choose folder to restore': 'पुनर्स्थापित करने के लिए फ़ोल्डर चुनें',
      'quiz': 'परीक्षा',
      'linked devices': 'लिंक किए गए उपकरण',
      'no linked devices': 'कोई लिंक्ड डिवाइस जहां नहीं मिला',
      'change user name': 'उपयोगकर्ता नाम परिवर्तन करें',
      'confirm change user name': 'क्या आप उपयोगकर्ता का नाम बदलना चाहते हैं?',
      'user name': 'उपयोगकर्ता नाम',
      'user name hint': 'उपयोगकर्ता का नाम दर्ज करें',
      'change user email': 'ई - मेल बदलें',
      'confirm change user email':
          'यदि आप उपयोगकर्ता के ईमेल को बदलते हैं, तो आपको डिवाइस को रिले करने की आवश्यकता होगी (माता-पिता या शिक्षक को इस डिवाइस के लिंक को फिर से बनाने की आवश्यकता होगी)। क्या आप जारी रखना चाहते हैं?',
      'user email': 'उपयोगकर्ता का ईमेल',
      'user email instructions':
          'उपयोगकर्ता द्वारा उपयोग किया जाने वाला ईमेल दर्ज करें। यदि उपयोगकर्ता के पास एक नहीं है तो यह माता-पिता का ईमेल हो सकता है। इस क्षेत्र में शिक्षक का या शिक्षक का ईमेल न डालें। ईमेल का उपयोग प्रत्येक उपयोगकर्ता के रूप में विशिष्ट पहचान करने के लिए किया जाता है। ईमेल का उपयोग सिंकिंग या क्विज़ के लिए उपकरणों को जोड़ने के लिए किया जाता है।',
      'user email hint': 'ईमेल दर्ज करें',
      'toggle visibility for all': 'सभी अवधारणाओं की दृश्यता बदलें',
      'item availability': 'आइटम उपलब्धता',
      'item availability instructions':
          'यदि कोई आइटम उपलब्ध नहीं है, तो आप इसे इंगित कर सकते हैं। गैर-उपलब्ध वस्तुओं को छवि पर लाल X के साथ दिखाया जाएगा',
      'is available': 'उपलब्ध है',
      'is not available': 'उपलब्ध नहीं है',
      'not available': 'उपलब्ध नहीं है',
      'available': 'उपलब्ध',
      'delete story': 'कहानी हटाओ',
      'confirm delete story': 'क्या आप वाकई कहानी हटाना चाहते हैं?',
      'level not enabled': 'स्तर सक्षम नहीं है',
      'not enough data':
          'पूर्वानुमानित लेखन सक्षम नहीं है क्योंकि पर्याप्त डेटा एकत्र नहीं किया गया है',
      'image size': 'छवि का आकार',
      'text size': 'शब्दों का आकर',
      'small': 'छोटा',
      'medium': 'मध्यम',
      'large': 'विशाल',
      'select video': 'वीडियो का चयन करें',
      'selected video': 'चयनित वीडियो:',
      'recording': 'रिकॉर्डिंग ...',
      'story object instructions':
          'आप उन्हें स्वाइप करके अवधारणाओं को खारिज कर सकते हैं। कुछ भी नहीं हटाया जाएगा। (अवधारणाओं को केवल संपादन मोड में हटा दिया जाता है)',
      'edit story name': 'कहानी का नाम संपादित करें',
      'select this concept': 'इस अवधारणा का चयन करें',
      'no story object instructions': '',
      'add story object': 'अवधारणा जोड़ें',
      'story name hint': 'कहानी का नाम दर्ज करें',
      'create new story': 'एक नई कहानी बनाएँ',
      'no stories instructions':
          'कहानियां आपको नए विचारों को समझाने के लिए अवधारणाओं (छवियों, ध्वनियों और वीडियो) से जुड़ने की अनुमति देती हैं। उदाहरण के लिए, आप चिड़ियाघर की यात्रा की व्याख्या कर सकते हैं, जो कि स्नान, कपड़े पहनना, नाश्ता करना, कार से यात्रा करना और जानवरों को देखना है।',
      'add story': 'कहानी जोड़ें',
      'please confirm': 'कृपया पुष्टि करें',
      'replace sound confirmation': 'क्या आप मौजूदा ऑडियो को बदलना चाहते हैं?',
      'replace': 'बदलने के',
      'voiceBoxSize': 'आवाज बॉक्स आकार',
      'big': 'बड़े',
      'select sound': 'ध्वनि रिकॉर्ड करें',
      'select sound instructions':
          'अपनी इच्छानुसार ध्वनि रिकॉर्ड करें। जब उपयोगकर्ता छवि पर क्लिक करता है तो यह ऑडियो वापस खेला जा सकता है।',
      'delete': 'हटाएं',
      'delete confirmation':
          'कृपया पुष्टि करें कि आप इस ऑब्जेक्ट को हटाना चाहते हैं। यह ऑपरेशन अपरिवर्तनीय है।',
      'warning not user created':
          'चेतावनी: इस ऑब्जेक्ट को एपीपी के साथ डिफ़ॉल्ट रूप से बंडल किया गया है। यदि आप इसे हटाते हैं तो इसे पुनर्प्राप्त करने का कोई तरीका नहीं है और आपको इसे प्रत्येक भाषा में छवि और पाठ के साथ मैन्युअल रूप से जोड़ना होगा।',
      'folder not empty will not delete':
          'हटाने से पहले फ़ोल्डर खाली होना चाहिए',
      'local device': 'युक्ति',
      'library': 'पुस्तकालय',
      'camara': 'कैमरा',
      'folder should talk': 'फ़ोल्डर का नाम कहें',
      'folder should talk instructions':
          'यदि आप उस पर क्लिक करते समय फ़ोल्डर का नाम सुनना चाहते हैं, तो सक्षम करें।',
      'loading images': 'चित्र लोड हो रहे हैं',
      'loading folders': 'फोल्डर लोड हो रहे हैं',
      'loading relations': 'संबंधों को लोड कर रहा है',
      'loading categories': 'श्रेणियाँ लोड हो रही हैं',
      'loading videos': 'वीडियो लोड हो रहे हैं',
      'loading sounds': 'लगता है लोड हो रहा है',
      'allowLongPressInLearningScreen':
          'लर्निंग मोड में एक अवधारणा को लंबे समय तक दबाने दें',
      'long press instructions':
          'लर्निंग मोड में, यदि उपयोगकर्ता किसी अवधारणा को लंबे समय तक दबाएगा, तो चयनित विकल्प की विस्तृत जानकारी प्रस्तुत करते हुए एक स्क्रीन दिखाई जाएगी।',
      'Not assigned': 'सौंपा नहीं गया है',
      'nothing unlocked': 'कुछ भी नहीं खुला',
      'nothing unlocked instructions':
          'इस ग्रिड का उपयोग करने से पहले, आपको उन अवधारणाओं को चुनना (दिखाना / अनलॉक करना) चाहिए जो आप चाहते हैं। उन्हें दबाकर अवधारणाओं को लॉक / अनलॉक करें। याद रखें कि इस स्तर में फ़ोल्डर्स को नहीं दिखाया गया है।',
      'please unlock':
          'कृपया कॉन्फ़िगरेशन, फ़ोल्डर में इच्छित आइटम अनलॉक / दृश्य करें',
      'default folder': 'डिफ़ॉल्ट फ़ोल्डर',
      'open folders': 'फ़ोल्डर खोलें',
      'default folder instructions':
          'इस फ़ोल्डर को डिफ़ॉल्ट फ़ोल्डर के रूप में चुनने के लिए, बटन पर क्लिक करें',
      'understood': 'समझ लिया',
      'not understood': 'नहीं समझे',
      'is understood': 'संकल्पना समझ में आती है',
      'is not understood': 'अवधारणा अभी तक समझ में नहीं आई है',
      'conceptIsUnderstood': 'समझ की अवधारणा',
      'conceptIsUnderstoodInstructions':
          'एक बार उपयोगकर्ता के पास स्पष्ट अवधारणा है, इसे समझे अनुसार चिह्नित करें। इससे शिक्षकों और अभिभावकों को संवाद करने में मदद मिलती है। समझे गए सभी अवधारणाओं को सीखने के ग्रिड में हरे रंग में फंसाया गया है।',
      'object visible': 'वर्तमान में ऑब्जेक्ट दिखाई दे रहा है',
      'object not visible': 'ऑब्जेक्ट वर्तमान में दिखाई नहीं दे रहा है',
      'visibility': 'दृश्यता',
      'visibility instructions':
          'उन छवियों को दिखाएं या छिपाएँ (अनलॉक / लॉक करें) जो आप चाहते हैं',
      'image to show': 'दिखाने के लिए चित्र',
      'text to show': 'दिखाने के लिए पाठ',
      'text to show instructions':
          'यह लर्निंग ग्रिड में प्रत्येक छवि के तहत दिखाया गया पाठ है।',
      'text to show hint': 'दिखाने के लिए पाठ दर्ज करें',
      'text to say': 'कहने के लिए पाठ',
      'text to say instructions':
          'आप बदल सकते हैं क्या कहना है! "मेरा नाम है ..." कहने के बजाय, आप इसे "मेरा नाम [यहाँ नाम रखें]" या "मेरी बहन [बहन का नाम]" रख सकते हैं। प्रदर्शित करने के लिए एक छोटा पाठ होना भी उपयोगी है, लेकिन कहने के लिए एक लंबा पाठ, जैसे कि जब कोई चित्र एक लंबे वाक्यांश का प्रतिनिधित्व करता है।',
      'text to say hint': 'कहने के लिए पाठ दर्ज करें',
      'edit': 'संपादित करें',
      'no default folder': 'डिफ़ॉल्ट फ़ोल्डर चयनित नहीं है',
      'please select a default folder':
          'एक डिफ़ॉल्ट फ़ोल्डर का चयन करें। केवल उस फ़ोल्डर से आपके द्वारा अनलॉक की गई छवियां दिखाई जाएंगी।',
      'select folder': 'डिफ़ॉल्ट फ़ोल्डर का चयन करें',
      'select a folder': 'आयात करने के लिए इच्छित दूरस्थ फ़ोल्डर का चयन करें',
      'current default folder': 'वर्तमान डिफ़ॉल्ट फ़ोल्डर:',
      'unlock': 'अनलॉक',
      'lock': 'ताला',
      'debug mode': 'डिबग मोड',
      'user profile': 'उपयोगकर्ता सेटिंग',
      'add': 'जोड़ना',
      'Grid size': 'ग्रिड आकार',
      'grid size instructions':
          'यदि आप चाहें, तो आप ग्रिड (कॉलम और पंक्तियों) के आकार को बदल सकते हैं। यह सेटिंग तभी बदलें जब आपके पास बड़ी स्क्रीन वाला कोई डिवाइस हो। सत्यापित करें कि उपयोगकर्ता प्रत्येक आइकन को आराम से देख और छू सकता है।',
      'operation completed successfully': 'ऑपरेशन सफलता पूर्वक सम्पन्न हुआ',
      'restore device': 'डिवाइस को पुनर्स्थापित करें',
      'user email to restore': 'पुनर्स्थापित करने के लिए उपयोगकर्ता ईमेल',
      'categories': 'श्रेणियाँ',
      'category': 'वर्ग',
      'close': 'बंद करे',
      'add folder': 'फ़ोल्डर जोड़ें',
      'add image': 'छवि जोड़ें',
      'add empty': 'खाली जगह जोड़ें',
      'add video': 'वीडियो जोड़ें',
      'add sound': 'ध्वनि जोड़ें',
      'new folder name': '',
      'new image name': '',
      'new video name': '',
      'new sound name': '',
      'show folder': 'फ़ोल्डर दिखाएँ',
      'hide folder': 'फ़ोल्डर छुपाएं',
      'delete folder': 'फोल्डर हटा दें',
      'folder instructions':
          'इसके विकल्प को सक्रिय करने के लिए किसी चित्र या खाली स्थान पर क्लिक या डबल क्लिक करें। अधिक विकल्पों का पता लगाने के लिए मेनू पर क्लिक करें।',
      'grid instructions':
          'उपयोगकर्ता की जरूरतों (बड़े आइकन के लिए) या डिवाइस की स्क्रीन के आकार के आधार पर, आप 5 स्तर से शुरू होने वाली छवियों के ग्रिड आकार को बदल सकते हैं।',
      'grid': 'ग्रिड',
      'Columns': 'कॉलम',
      'Rows': 'पंक्तियाँ',
      'folders': 'फ़ोल्डर',
      'level not found': 'स्तर नहीं मिला',
      'missing reinforcer': 'गुम प्रबल',
      'confirm reinforcer': 'कृपया पुष्टि करें कि आप उपयोग करना चाहते हैं ',
      'selected reinforcer': 'आपका वर्तमान चयनित पुनर्स्थापनाकार है:',
      'please select a reinforcer':
          'कृपया इस स्तर के लिए रीइन्फ़ॉर्मर का चयन करें',
      'cancel': 'रद्द करना',
      'learn': 'सीखना',
      'stories': 'कहानियों',
      'schedule': 'अनुसूची',
      'help videos': 'वीडियो की मदद करें',
      'images': 'इमेजिस',
      'colors': 'रंग की',
      'amber': 'अंबर',
      'blue': 'नीला',
      'cyan': 'सियान',
      'deepOrange': 'गहरा नारंगी',
      'deepPurple': 'गहरा बैंगनी',
      'green': 'हरा',
      'indigo': 'नील',
      'lightBlue': 'हल्का नीला',
      'lightGreen': 'हल्का हरा',
      'lime': 'चूना',
      'orange': 'संतरा',
      'pink': 'गुलाबी',
      'purple': 'बैंगनी',
      'red': 'लाल',
      'teal': 'टील',
      'yellow': 'पीला',
      'dark mode': 'डार्क मोड',
      'select this theme': 'इस विषय का चयन करें',
      'select voice': 'आवाज का चयन करें',
      'no voice selected':
          'कोई आवाज नहीं चुनी गई। यदि आप एक आवाज का चयन नहीं करते हैं, तो एपीपी किसी भी शब्द को कहने में सक्षम नहीं होगा।',
      'tts': 'भाषण का पाठ',
      'voice speed': 'आवाज की गति',
      'say': 'ज़ोर से कहें',
      'send by email': 'ईमेल द्वारा भेज',
      'user name not configured': 'उपयोगकर्ता नाम कॉन्फ़िगर नहीं किया गया',
      'change': 'परिवर्तन',
      'no valid voice found': 'कोई वैध आवाज नहीं मिली',
      'test voice': 'आवाज का परीक्षण करें। सक्रिय करने के लिए क्लिक करें।',
      'test text':
          'यदि आप इस वाक्य को सुन सकते हैं तो आपने आवाज को सही ढंग से कॉन्फ़िगर किया है।',
      'settings title': 'विन्यास',
      'levels': 'स्तर',
      'language': 'भाषा: हिन्दी',
      'select language instructions': 'अपनी पसंदीदा भाषा का चयन करें',
      'Chinese': 'चीनी',
      'English': 'अंग्रेज़ी',
      'Hindi': 'हिंदी',
      'Spanish': 'स्पेनिश',
      'Arabic': 'अरबी',
      'Malay': 'मलायी',
      'Russian': 'रूसी',
      'Bengali': 'बंगाली',
      'Portuguese': 'पुर्तगाली',
      'French': 'फ्रेंच',
      'German': 'जर्मन',
      'find image': 'छवि का पता लगाएं',
      'selected level': 'चयनित स्तर',
      'level1': 'स्तर 1',
      'level2': 'लेवल 2',
      'level3': 'स्तर 3',
      'level4': 'स्तर 4',
      'level5': 'स्तर 5',
      'level6': 'स्तर 6',
      'level7': 'स्तर 7',
      'level8': 'स्तर 8',
      'level9': 'स्तर 9',
      'level10': 'स्तर 10',
      'level11': 'स्तर 11',
      'change level': 'स्तर बदलें',
      'summary': 'सारांश',
      'level1 name': 'सुदृढ़कर्ता',
      'level1 summary':
          'इस स्तर का प्राथमिक कार्य उपयोगकर्ता को स्क्रीन को छूने के लिए प्रेरित करना है। सीखने का परिणाम तब प्राप्त होता है जब उपयोगकर्ता एक वस्तु का अनुरोध करने के लिए स्वतंत्र रूप से स्क्रीन को छूता है।',
      'Who does this level cater for': 'इस स्तर की पूर्ति कौन करता है?',
      'level1 Who does this level cater for':
          'एक बच्चा या वयस्क सीमित, शून्य संचार के लिए। इस स्तर का प्राथमिक कार्य एपीपी / डिवाइस से प्रेरित होने के लिए उपयोगकर्ता को प्रोत्साहित करना है',
      'How do we achieve this?': 'हम यह कैसे हासिल करते हैं?',
      'level1 How do we achieve this':
          'माता-पिता / शिक्षक / विशेषज्ञ को बच्चे की पुनर्स्थापना के बारे में पता होना चाहिए। रीइन्फोर्पर एक ऑब्जेक्ट या आइटम है जिसका उपयोगकर्ता आनंद लेता है या उसके साथ अवलोकन करता है। इसका एक अच्छा उदाहरण चॉकलेट जैसे खाद्य पदार्थ होगा।',
      'select reinforcer': 'रीइंफोर्मर का चयन करें',
      'How do we get the user to touch the screen?':
          'हम उपयोगकर्ता को स्क्रीन को छूने के लिए कैसे प्राप्त करते हैं?',
      'level1 How do we get the user to touch the screen':
          'स्तर 1 को एक स्क्रीन / बटन के रूप में सेट किया गया है जो स्पर्श होते ही बोलता है। चॉकलेट के उदाहरण का उपयोग करते हुए, एक माता-पिता / शिक्षक / विशेषज्ञ को चॉकलेट छवि दिखाने के लिए ऐप सेट क���ना चाहिए। माता-पिता / शिक्षक / विशेषज्ञ को प्रत्येक शिक्षण सत्र के दौरान चॉकलेट के कई छोटे टुकड़े होने चाहिए, जो उपयोगकर्ता को तत्काल इनाम प्रदान कर सकते हैं। याद रखें, शिक्षण सत्रों के लिए अलग समय निर्धारित करना महत्वपूर्ण है, लेकिन दिन का प्रत्येक क्षण एक शिक्षण अवसर हो सकता है। आईपैड को ऐसी जगह पर रखें जहां यूजर को इसे इस्तेमाल करने का हर मौका मिल सके। \n\n अपने शिक्षण सत्र को पूरा करना \n1। उपयोगकर्ता को चॉकलेट का एक छोटा टुकड़ा प्रदान करें। उपयोगकर्ता के बैठने के लिए सबसे अच्छा है, हालांकि यह हमेशा संभव नहीं हो सकता है। \n2। उपयोगकर्ता को स्क्रीन को छूने के लिए प्रोत्साहित करने के लिए \'हैंड ओवर हैंड\' का उपयोग करें। ‘हैंड ओवर हैंड’ एक शिक्षण दृष्टिकोण है जिसका उपयोग ऑटिस्टिक बच्चों के साथ किया जाता है। अभिभावक / शिक्षक / विशेषज्ञ बटन को दबाने के लिए उसे प्रोत्साहित करके उपयोगकर्ता की सहायता करता है। माता-पिता / शिक्षक / विशेषज्ञ उपयोगकर्ता के हाथ पर अपना हाथ रखते हैं और उन्हें चयनित बटन की ओर निर्देशित करते हैं। * \n3। जैसे ही APP बोलता है, माता-पिता / शिक्षक / विशेषज्ञ को तुरंत उपयोगकर्ता को चॉकलेट देनी चाहिए। \n4। यह नियमित रूप से 5 मिनट की अवधि के लिए दोहराया जाना चाहिए जब तक कि उपयोगकर्ता निराश न हो जाए। उपयोगकर्ता को चॉकलेट तब तक प्रदान न करें जब तक कि बटन दबाया नहीं गया हो, भले ही वे कितने निराश हों। \n5। यदि उपयोगकर्ता निराश हो जाता है, तो हार न मानें। यह एक लंबी प्रक्रिया है, लेकिन दीर्घकालिक लाभ उपयोगकर्ता को जीवन के लिए निर्धारित करेगा। उपयोगकर्ता के शांत होने पर इस कार्य को रोकें और फिर से देखें। दिन भर में नियमित अंतराल पर 1- \n\n चरण की प्रक्रिया करें। कई उपयोगकर्ता इस स्तर पर सफल होने के लिए बहुत तेज होंगे और अन्य लोग बहुत मेहनत, धैर्य और प्रयास करेंगे। \n\n * इस सहायता के बल को धीरे-धीरे कम किया जाना चाहिए। इसे पूरी तरह से हटाने में महीनों लग सकते हैं।',
      'How do you know ready for level 2':
          'आप कैसे जानते हैं कि उपयोगकर्ता स्तर 2 के लिए तैयार है?',
      'level1 How do you know ready for level 2':
          'उपयोगकर्ता "हैंड ओवर हैंड" की आवश्यकता को कम कर देगा क्योंकि आप नोटिस करते हैं कि आपका बच्चा इस एपीपी को समझना शुरू कर देता है जिससे उन्हें अपने रिफ़रेंसर प्राप्त करने में मदद मिलती है। जब उपयोगकर्ता माता-पिता / शिक्षक के किसी भी समर्थन के बिना स्वतंत्र रूप से और लगातार बटन दबा रहा है, तो उपयोगकर्ता स्तर 2 के लिए तैयार है',
      'level2 name': 'विकल्प',
      'level2 summary':
          'यह स्तर उपयोगकर्ता को सिखाने के लिए डिज़ाइन किया गया है कि पुरस्कृत परिणाम के लिए एक से अधिक विकल्प हैं। \n\n साझाकरण परिणाम: उपयोगकर्ता के पास लगातार और समझ के साथ दोनों वस्तुओं का अनुरोध करने की क्षमता होगी।',
      'level2 Who does this level cater for':
          'यह स्तर उन उपयोगकर्ताओं के लिए पूरा होता है, जिन्होंने स्तर 1 पर पहुंच बनाई है और जिन्हें \'हैंड ओवर हैंड\' की न्यूनतम आवश्यकता है। उपयोगकर्ता दो विकल्पों की पेशकश करके आगे बढ़ता है जो उन्हें एक विकल्प बनाने के लिए प्रोत्साहित करते हैं।',
      'level2 How do we achieve this':
          'माता-पिता / शिक्षक / विशेषज्ञ को यह सुनिश्चित करना होगा कि स्क्रीन पर जो दूसरी छवि जोड़ी जा रही है, वह एक दूसरा रीइन्फोर्मर है, उदाहरण के लिए, रस। उपयोगकर्ता के पास अब अपनी दो पसंदीदा वस्तुओं का अनुरोध करने का विकल्प होगा और यह ऐप के साथ उनके संबंधों का निर्माण करेगा।',
      'select second reinforcer': 'दूसरे रीइन्फोर्मर का चयन करें',
      'level2 How do we get the user to touch the screen':
          'माता-पिता / शिक्षक / विशेषज्ञ स्तर 1 में नियोजित समान रणनीतियों का उपयोग करेंगे। सारांश में, दो वस्तुओं को आसानी से उपलब्ध होना चाहिए और उपयोगकर्ता को अनुरोध के अनुसार उपलब्ध कराया जाएगा। यह सुनिश्चित करना महत्वपूर्ण है कि उपयोगकर्ता को सही आइटम मिल रहा है और दो छवियों में अंतर के बारे में पता है। उपयोगकर्ता को आइटम में से एक दिखाया जाना चाहिए और इसे सही और लगातार अनुरोध करना चाहिए। डेटा प्रतिक्रियाओं को उजागर करने और सटीकता दिखाने के लिए उपलब्ध होगा। यह स्तर प्रगति के लिए सबसे तेज़ स्तरों में से एक है क्योंकि उपयोगकर्ता को पहले से ही स्तर 1 पुनर्निवेशक से प्रेरित होना चाहिए।',
      'How do you know ready for level 3':
          'आप कैसे जानते हैं कि उपयोगकर्ता स्तर 3 के लिए तैयार है?',
      'level2 How do you know ready for level 3':
          'उपयोगकर्ता स्वतंत्र रूप से ऐप का उपयोग करने में बेहतर आत्मविश्वास दिखाएगा और hand हैंड ओवर हैंड ’की सीमित आवश्यकता होनी चाहिए। जब उपयोगकर्ता माता-पिता / शिक्षक / विशेषज्ञ से सीमित समर्थन के साथ स्वतंत्र रूप से और लगातार बटन दबा रहा है, तो यह एक संकेत है कि उपयोगकर्ता स्तर 3 के लिए तैयार है।',
      'level3 name': 'बुरे विकल्प',
      'level3 summary':
          'इस स्तर पर उपयोगकर्ता समझ जाएगा कि ऐप एक परिणाम प्रदान करता है जो उसे / उसे खुशी देता है। यह महत्वपूर्ण है कि इस स्तर को प्रदान किया जाए क्योंकि यह प्रगति उपयोगकर्ता को सिखाती है कि सभी विकल्प पुरस्कृत नहीं हैं लेकिन वे संचार हैं। यह स्तर कम समय में हासिल किया जाता है। सीखने के परिणाम: उपयोगकर्ता को गैर-पसंदीदा विकल्प प्राप्त करने के साथ अरुचि दिखाने के लिए मनाया जाना चाहिए। उपयोगकर्ता अब इस विकल्प का चयन नहीं करेगा।',
      'level3 Who does this level cater for':
          'यह स्तर उन उपयोगकर्ताओं के लिए पूरा होता है, जिनके पास स्तर 1 और 2 हैं और जिन्हें \'हैंड ओवर हैंड\' की न्यूनतम / शून्य आवश्यकता है। उपयोगकर्ता तीसरे विकल्प की पेशकश करके आगे बढ़ता है जो एक अनुकूल विकल्प नहीं है।',
      'level3 How do we achieve this':
          'विकास के इस स्तर पर, उपयोगकर्ता के पास अब एक गैर-पसंदीदा विकल्प होगा। माता-पिता / शिक्षक / विशेषज्ञ को यह सुनिश्चित करना होगा कि स्क्रीन पर जोड़ी जा रही तीसरी छवि गैर-पसंदीदा आइटम है, उदाहरण के लिए, एक जुर्राब। उपयोगकर्ता के पास अब दो पसंदीदा विकल्प और एक गैर-पसंदीदा विकल्प का अनुरोध करने का विकल्प होगा।',
      'select third reinforcer': 'तीसरा शब्द चुनें',
      'level3 How do we get the user to touch the screen':
          'उपयोगकर्ता को अब ऐप द्वारा प्रेरित किया जाना चाहिए और छवियों को छूने के लिए साज़िश किया जाएगा। उन्हें छवियों से आज तक खुशी मिली है। उपयोगकर्ता जिज्ञासु होगा और उसे गैर-पसंदीदा आइटम से सकारात्मक परिणाम प्राप्त करना चाहिए। वह / वह माता-पिता / शिक्षक / विशेषज्ञ से प्रेरणा के बिना प्रेरित किया जाना चाहिए, लेकिन अगर यह मामला नहीं है तो माता-पिता / शिक्षक / विशेषज्ञ को इस बातचीत को प्रोत्साहित करने के लिए स्तर 1 से रणनीतियों का पालन करना चाहिए। यदि उपयोगकर्ता किसी भी तीन छवियों का चयन / स्पर्श करता है, तो वे आइटम को तुरंत प्राप्त करेंगे। पहले तीन स्तरों को उपयोगकर्ता को सिखाने के लिए डिज़ाइन किया गया है कि किसी आइटम का अनुरोध कैसे करें। यह स्तर इस तथ्य को समेकित करता है कि सभी विकल्प सुखद नहीं हैं, वे अनुरोध हैं। उपयोगकर्ता अब इस बात पर विचार करना सीखेंगे कि वे जिन चित्रों को स्पर्श करते हैं वे आइटम हैं जो उन्हें प्राप्त होते हैं, भले ही वे उन्हें पसंद करें या नहीं।',
      'How do you know ready for level 4':
          'आप कैसे जानते हैं कि उपयोगकर्ता स्तर 4 के लिए तैयार है?',
      'level3 How do you know ready for level 4':
          'गैर-पसंदीदा आइटम प्राप्त करने पर उपयोगकर्ता निराशा दिखाएगा और अनुरोध की गई अन्य वस्तुओं से प्रसन्न होना जारी रखेगा। माता-पिता / शिक्षक / विशेषज्ञ को स्वतंत्र रूप से ऐप का उपयोग करने में बेहतर आत्मविश्वास का पालन करना जारी रखना चाहिए। जब उपयोगकर्ता माता-पिता / शिक्षक / विशेषज्ञ के किसी भी समर्थन के बिना स्वतंत���र रूप से और लगातार बटन दबा रहा है, तो उपयोगकर्ता स्तर 4 के लिए तैयार है। डेटा इन टिप्पणियों को साबित करेगा। उपयोगकर्ता को गैर-पसंदीदा विकल्प प्राप्त करने के साथ अरुचि दिखाने के लिए भी मनाया जाना चाहिए। उपयोगकर्ता अब इस विकल्प का चयन नहीं करेगा।',
      'level4 name': 'आवाज बॉक्स',
      'level4 summary':
          'यह स्तर भाषा संरचना का निर्माण शुरू करने के लिए डिज़ाइन किया गया है जिसका उपयोग अगले स्तरों में किया जाएगा। उपयोगकर्ता के लिए इनाम केवल तभी दिया जाएगा जब वह छवि का चयन करता है और आवाज बॉक्स पर छूता है। सीखने के परिणाम: उपयोगकर्ता एक चुने हुए आइटम का चयन करेगा और यह समझेगा कि वह आइटम तब तक प्रदान नहीं किया जाएगा जब तक कि वह वॉयस बॉक्स को नहीं छूता।',
      'level4 Who does this level cater for':
          'यह स्तर उन उपयोगकर्ताओं के लिए पूरा होता है, जिन्होंने 1-3 के स्तर तक पहुंच बनाई है और अब स्वतंत्र रूप से न्यूनतम / शून्य over हैंड ओवर हैंड ’समर्थन के साथ स्वतंत्र रूप से ऐप का उपयोग कर रहे हैं। यह स्तर माता-पिता / शिक्षक / विशेषज्ञ और उपयोगकर्ता के लिए निराशाजनक स्तरों के लिए अधिक चुनौतीपूर्ण स्तरों में से एक है। इस स्तर का उद्देश्य उपयोगकर्ता को एक आवाज बॉक्स का उपयोग करना सिखाना है जो भाषा के विकास के लिए अनुमति देता है। इस स्तर पर, माता-पिता / शिक्षक / विशेषज्ञ दो-शब्द स्तर का उपयोग करने के लिए उपयोगकर्ता को तैयार करके भाषा विकसित करने की योजना बना रहे हैं। चॉकलेट चाहते हैं। इस स्तर पर समय और धैर्य लगता है। इसे थोड़े समय के लिए वापस \'हैंड ओवर हैंड\' करने की आवश्यकता हो सकती है।',
      'level4 How do we achieve this':
          'इस स्तर पर, स्तर 3 स्क्रीन समान तीन विकल्पों के साथ बनी हुई है, हालांकि स्क्रीन पर अब स्क्रीन के शीर्ष पर एक लंबी पट्टी है। इस पट्टी को \'वॉयस बॉक्स\' कहा जाता है। जब उपयोगकर्ता सामान्य छवियों को छूता है, तो शब्द अब तुरंत नहीं बोला जाएगा। अब इसे स्क्रीन के शीर्ष पर वॉयस बॉक्स में प्रदर्शित किया जाएगा। चयनित शब्दों को बोलने में सक्षम बनाने के लिए उपयोगकर्ता को अब वॉइस बॉक्स को स्पर्श करना होगा।',
      'level4 How do we get the user to touch the screen':
          'जब आइटम का अनुरोध किया जाता है तो उपयोगकर्ता को तत्काल संतुष्टि नहीं मिलेगी। उसे / उसे आवाज बॉक्स को छूने के लिए प्रोत्साहित किया जाना चाहिए। इसके लिए शुरू में उपयोगकर्ता को सिखाने के लिए \'हैंड ओवर हैंड\' की आवश्यकता होगी और वह दिखाएगा जो अपेक्षित है। सभी उपयोगकर्ता इसे एक अलग दर पर सीखेंगे। अभिभावक / शिक्षक / विशेषज्ञ को उपयोगकर्ता की समझ के आधार पर धीरे-धीरे \'हैंड ओवर हैंड\' को कम करना चाहिए।',
      'How do you know ready for level 5':
          'आप कैसे जानते हैं कि उपयोगकर्ता स्तर 5 के लिए तैयार है?',
      'level4 How do you know ready for level 5':
          'उपयोगकर्ता स्वतंत्र रूप से या over हैंड ओवर हैंड सपोर्ट ’के साथ, आइटम का चयन करेगा और वॉइस बॉक्स को स्पर्श करेगा। डेटा एक उच्च प्रतिशत सफलता दर दिखाएगा।',
      'level5 name': 'शब्दावली बनाना',
      'level 5 folders': 'फ़ोल्डरों का व्यवहार',
      'level 5 folder info':
          'इस स्तर में फ़ोल्डर नहीं दिखाए गए हैं। यह जानबूझकर है इसलिए उपयोगकर्ता अन्य फ़ोल्डरों में नेविगेट नहीं करेगा और स्तर के उद्देश्य से विचलित नहीं होगा',
      'level5 summary':
          'यह स्तर उपयोगकर्ता के लिए भाषा बनाने के लिए प्राथमिक उद्देश्य के साथ शिक्षण प्रक्रिया की शुरुआत है। \n\nमूल्यांकन परिणाम: उपयोगकर्ता को एक फ़ोल्डर में 6 या अधिक शब्दों की स्पष्ट समझ होगी।',
      'level5 Who does this level cater for':
          'This level caters for Users who have accessed Levels 1-4. Users will generally be using the App independently at this stage although some may require ‘hand over hand’ support. \n\nThis level is the start of the teaching process with the primary aim being to build language for the User. The parent/teacher/specialist role becomes more important at this stage as new words should now be introduced to the User, and the parent/teacher/specialist must select words that would be important to the User. The words must also be within the same category ie. using the example of chocolate would require building language for snack items, and the snack items must be those preferred by the User. The categories have been pre-arranged into folders and the words can be made visible as required. If the words/items are not currently available on the folder, the parent/teacher/specialist can take a photo and add them in.\n\nAt this stage, the parent/teacher/specialist must follow the guidance that is provided in the teaching section regarding the use of videos, cards and items. This level takes time and a lot of patience. ‘Hand over hand’ may continue until the User builds his/her confidence.',
      'level5 How do we achieve this':
          'The Parent/Teacher/Specialist section within the App provides detail on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. \n\nThis section includes:\n1.	Continuing to request items\n2.	Matching pictures\n3.	Matching picture to object\n4.	Matching picture to item',
      'level5 How do we get the user to touch the screen':
          'This level requires the User to focus and remain seated to improve communication and build vocabulary. It is unlikely that the User will be willing to engage and therefore it is essential that the main reinforcer is re-introduced. The main reinforcer discussed as an example in the previous summaries was chocolate. In this case the chocolate must be readily available throughout these sessions as the User will be motivated to work if they are provided with a reward. \n\nInitially, the User should be rewarded with their reinforcer after EVERY successful item has been requested ie. when matching every item, the User should be rewarded with a small treat such as a third of a chocolate button. Gradually reduce the reinforcer treat as the User becomes more confident. In time, the User will no longer require a reinforcer. \n\For many this may require ‘hand over hand’ to initially teach the User and show what is expected. All Users will learn this at a different rate. The parent/teacher/specialist should gradually reduce the ‘hand over hand’ depending on the understanding of the User.',
      'How do you know ready for level 6':
          'How do you know the user is ready for level 6?',
      'level5 How do you know ready for level 6':
          'The User will have developed words within this category ie. snacks. This category will continue to be known as the ‘snack’ folder. When a folder contains 6 or more items the User is ready to progress to Level 6. The User would be expected to select items independently although some Users may still prefer ‘hand over hand’ support at this time. Data will continue to be available to show a high percentage success rate in identifying the chosen items. ',
      'level6 name': 'Creating folders',
      'level6 summary':
          'This Level allows Users to develop their language by increasing folders. Folders are created to allow Users to compartmentalize different topics ie. food, transport, clothes. \n\nLearning outcome: The User will show confidence in selecting items. They will be able to move between a minimum of three folders with ease.',
      'level6 Who does this level cater for':
          'This level differs from the others in that it caters for two groups:\n1.	Users who have accessed levels 1-5. These Users will be developing in confidence and most will be using the App independently. Some Users may still require extra support with ‘hand over hand’. Do not discourage this as all Users will develop at a different rate – as confidence grows, the need for support will reduce. \n2.	This would be the suggested stage to introduce the App to Users with limited/zero communication who are visual learners with moderate to good understanding. The parent/teacher/specialist should familiarize themselves with the teaching strategies employed in Levels 1-5 to promote maximum progress and understanding.\n\nThis Level allows Users to develop their language by increasing folders. Folders are created to allow Users to compartmentalize different topics ie. food, transport, clothes. \n\nThe Users who have accessed Levels 1-5 should be engaged and have a clear understanding of what is expected of them. This level allows the parent/teacher/specialist to add different folders to increase the language/speech opportunities. Consider this level as being similar language development for any individual learning a new language. Typical language development starts with one word ie. juice, cat, car. The words come from different folders. We, at Lucas Education, have created a template of folders that we believe are essential for day-to-day communication.',
      'level6 How do we achieve this':
          'One additional folder will be made available to the existing folder in Level 5. For new Users, two folders will be available. The parent/teacher/specialist selects a second folder which contains items that are motivating to the User. When data shows that the User has clearly understood 5 words, the App with allow the opportunity to unlock 5 more words within this folder as well as another folder. \n\nThis process will continue as your User continues to develop and grow. This is a natural process and the same process that all individuals go through when learning to speak and communicate. Level 6 is on-going learning and development.   \n\nThe Parent/Teacher/Specialist section within the App provides further detail on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. Games will be available in due course.\n\nThis section includes:\n1.	Continuing to request items\n2.	Matching pictures\n3.	Matching picture to object\n4.	Matching picture to item',
      'level6 How do we get the user to touch the screen':
          'This Level continues to require the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the program on the move. Examples of such opportunities are when seated in the car or maybe your child enjoys sitting in their pram.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be motivated to work if they are provided with a reward. It is important however to reduce the frequency of the reward. As the language develops, the reinforcer should be reduced and removed.  \n\nThis may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication.',
      'How do you know ready for level 7':
          'How do you know the user is ready for level 7?',
      'level6 How do you know ready for level 7':
          'The User will show confidence in selecting items. They will be able to move between a minimum of three folders with ease. Data will continue to be available to show a high percentage success rate in identifying the chosen items.',
      'level7 name': 'Sentence structure – part one',
      'level7 summary':
          'This Level allows Users to develop sentence structure by introducing a sentence starter. Folders are predesigned to predict possible sentence starters for each folder. \n\nLearning outcome: The User will show confidence in selecting the sentence starter followed by the chosen item. The words will be activated by pressing the voicebox.',
      'level7 Who does this level cater for':
          'This level caters for Users who have accessed Level 6.\n\nThis Level allows Users to develop sentence structure by introducing a sentence starter. Folders are predesigned to predict possible sentence starters for each folder. The option is also available to personalise words.',
      'level7 How do we achieve this':
          'In the previous section, typical language development was discussed. This section takes language development to the next level. Children move from one word level to two. We, at Lucas Education achieve this by introducing sentence starters which vary depending on the folder. Examples of this would be as follows:\n1.	Food folder – I want chocolate……I do not want chocolate.\n2.	Animal folder – I hear cat\n3.	Transport folder – I see car.\n\nSimilar to Level 4, the User may become frustrated during the initial stages of this Level as they are now expected to include a word prior to what has been expected of them in previous levels. For many reinforcers must be introduced again to ensure that the User remains motivated. \n\nAs with the previous folder the words/images will be released when data proves that the User is capable of understanding and consistently includes the sentence starter before requests. Level 7 is on-going learning and development.   \n\nThe Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources.',
      'level7 How do we get the user to touch the screen':
          'This Level also requires the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the programme on the move. Examples of such opportunities are when seated in the car or maybe your child enjoys sitting in their pram.\n\nOnce both icons, namely the sentence starter and the requested item, are appearing in the voice box, the User must touch the voice box and the App will say the sentence for example “I want chocolate” At this point the parent/teacher will give the User what he/she is requesting. The voice box should not be activated until an action and an image are added. Both icons must be spoken in the one voice box; they cannot be selected and spoken independently.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be more motivated to work if they are provided with a reward. This may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication. ',
      'How do you know ready for level 8':
          'How do you know the user is ready for level 8?',
      'level7 How do you know ready for level 8':
          'The User will show confidence in selecting the sentence starter followed by the chosen item. Data will continue to be available to show a high percentage success rate in identifying the chosen items and more sentence starters will be unlocked to develop language further.',
      'level8 name': 'Sentence structure – part two',
      'level8 summary':
          'This level caters for Users who have accessed Level 7.\n\nThis Level allows Users to develop sentence structure by including a sentence closer. Folders are predesigned to predict possible sentence closers for each folder. The option is also available to personalise words.',
      'level8 Who does this level cater for':
          'This level caters for Users who have accessed Level 7.\n\nThis Level allows Users to develop sentence structure by including a sentence closer. Folders are predesigned to predict possible sentence closers for each folder. The option is also available to personalise words.',
      'level8 How do we achieve this':
          'In Level 5, typical language development was promoted and in Level 6 the sentence starters were added. This Level progresses language development to the next level by closing the sentences. We, at Lucas Education achieve this by providing predicted sentence closers which vary depending on the folder. Examples of this would be as follows:\n1.	Food folder – I want chocolate please\n2.	Animal folder – I hear cat\n3.	Transport folder – I see car.\n\nThe final part of the sentences can or cannot be used in conjunction with the action and objects. For example in some cases, the closing part can be used alone eg. All done!\n\nSimilar to Levels 4 and 7, the User may become a little frustrated during the initial stages of this Level as they are now expected to include a word following what has been expected of them in previous levels. For many, reinforcers must be introduced again to ensure that the User remains motivated. \n\nAs with the previous folder the words/images will be released when data proves that the User is capable of understanding and consistently includes the sentence closer after requests. Level 8 is on-going learning and development.\n\The Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. ',
      'level8 How do we get the user to touch the screen':
          'This Level also requires the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the programme on the move. Such opportunities could be made possible at snack time or perhaps when ordering food at a takeaway.\n\nWhen all three icons, namely the sentence starter, the requested item and the sentence closer, are appearing in the voice box, the User must touch the voice box and the App will say the sentence, for example “I want chocolate, please!”. At this point the parent/teacher will give the person what she/he is requesting. The voice box should not be activated until an action, an image and a closer are added. All three icons must be spoken in the one voice box; they cannot be selected and spoken independently.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be more motivated to work if they are provided with a reward. This may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication.',
      'How do you know ready for level 9':
          'How do you know the user is ready for level 9?',
      'level8 How do you know ready for level 9':
          'The User will show confidence in selecting the sentence starter followed by the chosen item and sentence closer. Data will continue to be available to show a high percentage success rate in identifying the chosen items and more sentence closers will be unlocked to develop language further. \n\nUsers at this Level are now capable of accessing Levels 9, 10 and 11. All three Levels are challenging and cater for higher functioning Users. These Levels do not have to taught in a sequential order, for example, the User may find difficulty in progressing through Levels 9 and 10, but may succeed in Level 11.',
      'level9 name': 'Grammar and developed literacy',
      'level9 summary':
          'This Level allows higher functioning Users the opportunity to focus on building sentence structure by developing literacy through use of conjunctions, connectives and pronouns.\nThis is an important building block to teaching the User how to read. \n\nTHIS IS ONE OF THE MORE CHALLENGING LEVELS.\n\nLearning outcome: The User will have the ability to communicate with confidence by linking words with conjunctives and using other literacy cues to develop language further.',
      'level9 Who does this level cater for':
          'This level caters for Users who have accessed Level 8.\n\nThis Level allows higher functioning Users the opportunity to focus on building sentence structure by developing literacy through use of conjunctions, connectives and pronouns.\n\nTHIS IS ONE OF THE MORE CHALLENGING LEVELS.',
      'level9 How do we achieve this':
          'The Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. \n\nData will also assist in gathering success criteria and in unlocking progressive language.',
      'level9 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program. ',
      'How do you know ready for level 10':
          'How do you know the user is ready for level 10?',
      'level9 How do you know ready for level 10':
          'The User is capable to access Level 10 directly from Level 8. All Levels can be used at the same time to develop language. Words will be unlocked when data dictates that the User is ready. ',
      'level10 name': 'Learning words',
      'level10 summary':
          'This Level allows higher functioning Users the opportunity to focus on learning words as opposed to pictures. This Level progresses by removing pictures and replacing them with the name/text of each object. This is the initial step in providing our non-verbal children with the opportunity to read.\n\nLearning outcome: The User will have the ability to communicate with the same confidence by using words as opposed to images.',
      'level10 Who does this level cater for':
          'This level caters for Users who have accessed Level 8 or 9.\n\nThis Level allows higher functioning Users the opportunity to focus on learning words as opposed to pictures. Users who require images should bypass this Level and access Level 10.',
      'level10 How do we achieve this':
          'The Parent/Teacher/Specialist will have an understanding of the favourite words selected by the User. Data will also assist in gathering such details. All words have been set up to show a large image with a small defined word below (show example). The Parent/Teacher/Specialist will now gradually reduce the size of the picture for the favourite words, whilst increasing the size of the word. With time the Parent/Teacher/Specialist will aim to remove the image and only provide the User with the word. Once again, experience and data will provide feedback on the understanding of the User and their readiness to remove images from other buttons.',
      'level10 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program. If they are unable to use the words when the images have been reduced, this is a sign that the User is not ready for this Level and it must be revisited at another stage.',
      'How do you know ready for level 11':
          'How do you know the user is ready for level 11?',
      'level10 How do you know ready for level 11':
          'The User will show confidence in selecting icons with words as opposed to images. Data will continue to be available to show a high percentage success rate in identifying the chosen items.',
      'level11 name': 'predictive images/writing',
      'level11 summary':
          'This Level allows Users the opportunity to communicate with greater speed by providing the User with the opportunity to select predicted images or words. \n\nLearning outcome: The User will have the ability to communicate with the same confidence although at a greater speed and fluency.',
      'level11 Who does this level cater for':
          'This level caters for Users who have accessed Level 8.\n\nThis Level allows Users the opportunity to communicate with greater speed. ',
      'level11 How do we achieve this':
          'This Level provides the User with the opportunity to select predicted images or words. The App will provide a list of actions to be selected by the user. Once an action is selected, the pictures/words to be shown will be presented depending on the frequency of usage for each word. The most used words will appear higher in the grid while less used words for that specific action will appear lower on the grid.',
      'level11 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program',
    },
    // Spanish (527 million)
    'es': {
      'app title': 'LUCAS',
      'relation': 'Relación',
      'schedule day': 'Programa día',
      'sound': 'Sonido',
      'video': 'Vídeo',
      'story object': 'Objeto de historia',
      'translation': 'Traducción',
      'start': 'Iniciar copia de seguridad',
      'backup device': 'Copia de seguridad de este dispositivo',
      'Minimum level to show': 'Nivel mínimo para mostrar',
      'background color': 'Color de fondo',
      'loading empty spaces': 'Cargando espacios vacíos',
      'loading translations': 'Cargando traducciones',
      'Drag and drop enabled': 'Arrastrar y soltar habilitado',
      'Drag and drop disabled': 'Arrastrar y soltar inhabilitado',
      'about this app': 'Acerca de esta aplicación',
      'text to find': 'Encontrar',
      'text to find instructions':
          'Ingrese la palabra o parte de la palabra para encontrar en la pregunta. Déjelo en blanco para buscar todo.',
      'number of concepts': 'Numero de conceptos',
      'one concept': 'Un concepto',
      'two concepts': 'Dos conceptos',
      'three or more': 'Tres o más conceptos',
      'students': 'Estudiantes',
      'find results': 'Encuentra resultados',
      'result is correct': 'El resultado es correcto.',
      'result is wrong': 'El resultado es incorrecto.',
      'play quiz': 'Escuchar cuestionario',
      'silent quiz ongoing': 'Prueba silenciosa en curso',
      'send to device': 'Enviar a:',
      'quiz type': 'Tipo de cuestionario',
      'quiz show image': 'Mostrar imagenes',
      'quiz sound image': 'Pronuncia los conceptos',
      'quiz show sound and image': 'Pronuncia los conceptos y muestra imágenes',
      'quiz do not show anything': 'No mostrar nada',
      'send quiz': 'Enviar cuestionario',
      'schedule_title1': 'Bienvenidos',
      'schedule_title2': 'Hora del día',
      'schedule_title3': 'Modo de edición',
      'schedule_title4': 'Agregar objeto',
      'schedule_title5': 'Administrar días',
      'schedule_text1':
          'El horario permite visualizar cosas que sucederán. Le permite a su usuario entender lo que hará hoy y en el futuro. Puede mantener presionado un elemento para verlo más grande.',
      'schedule_text2':
          'Ocultar / mostrar la hora del día en que ocurrirá cada actividad.',
      'schedule_text3':
          'El modo de edición permite gestionar conceptos. En el modo de edición, se mostrarán todos los días y puede hacer clic en cada objeto para interactuar con él.',
      'schedule_text4':
          'Seleccione el día / hora y la imagen que desea que se muestre.',
      'schedule_text5': 'Si necesita agregar nuevos días, haga clic aquí.',
      'existing concept':
          'Ya existe un concepto para el mismo día y hora. Corrija y vuelva a intentar.',
      'please select an object': 'Por favor seleccione un objeto',
      'please select a day': 'Por favor seleccione un día',
      'select an object': 'Selecciona un objeto',
      'add object': 'Agregar objeto a la agenda',
      'select day': 'Seleccione dia',
      'selected day': 'Dia seleccionado',
      'select hour': 'Seleccione hora',
      'monday': 'Lunes',
      'tuesday': 'Martes',
      'wednesday': 'Miercoles',
      'thursday': 'Jueves',
      'friday': 'Viernes',
      'saturday': 'Sabado',
      'sunday': 'Domingo',
      'school': 'Escuela',
      'home': 'Casa',
      'today': 'Hoy',
      'tomorrow': 'Mañana',
      'no action required title': 'No se requiere ninguna acción.',
      'no action required info':
          'Lea la información proporcionada y continúe haciendo clic en el ícono Aprende',
      'reset': 'Restablecer',
      'video_title1': 'Video introductorio',
      'video_title2': 'Nivel 1',
      'video_title3': 'Nivel 2',
      'video_title4': 'Nivel 3',
      'video_title5': 'Nivel 4',
      'video_title6': 'Nivel 5',
      'video_title7': 'Nivel 6',
      'video_title8': 'Nivel 7',
      'video_title9': 'Nivel 8',
      'video_title10': 'Nivel 9',
      'video_title11': 'Nivel 10',
      'video_title12': 'Nivel 11',
      'video_title13': 'Ajustes de usuario',
      'video_text1': 'Nuestro video introductorio',
      'video_text2': 'Video de refuerzo',
      'video_text3': 'Video de opciones',
      'video_text4': 'Video de malas elecciones',
      'video_text5': 'Video de caja de voz',
      'video_text6': 'Video de vocabulario de construcción',
      'video_text7': 'Crear carpetas de video',
      'video_text8': 'Estructura de la oración - video de la primera parte',
      'video_text9': 'Estructura de la oración: video de la segunda parte',
      'video_text10': 'Gramática y video de alfabetización desarrollado',
      'video_text11': 'Video de aprendizaje de palabras',
      'video_text12': 'Imágenes predictivas / escritura de video',
      'video_text13': 'Video de configuración del usuario',
      'showHelper_LevelSettings_title1': 'Primero:',
      'showHelper_LevelSettings_title2': 'Información a llenar',
      'showHelper_LevelSettings_title3': 'Cambiar nivel',
      'showHelper_LevelSettings_title4': 'Pantalla de aprendizaje',
      'showHelper_LevelSettings_text1':
          'Lea toda la información que le hemos proporcionado.',
      'showHelper_LevelSettings_text2':
          'Algunos niveles requieren información de su parte. Están claramente resaltados',
      'showHelper_LevelSettings_text3':
          'Si necesita cambiar los niveles, hágalo presionando este icono',
      'showHelper_LevelSettings_text4':
          'Una vez listo, regrese a la pantalla de aprendizaje',
      'showHelper_image-settings_title1': 'Buscar',
      'showHelper_image-settings_title2': 'Editar',
      'showHelper_image-settings_title3': 'Tamaño de la cuadrícula',
      'showHelper_image-settings_title4': 'Ayuda',
      'showHelper_image-settings_text1':
          'Ingrese el texto y presione el botón para buscar las imágenes.',
      'showHelper_image-settings_text2':
          'Haga clic en la imagen para editarla.',
      'showHelper_image-settings_text3':
          'Cambie el tamaño de la cuadrícula presionando este botón',
      'showHelper_image-settings_text4':
          'Activa o desactiva la ayuda con este botón',
      'showHelper_folders_title1': 'Clic',
      'showHelper_folders_title2': 'Doble clic',
      'showHelper_folders_title3': 'Mantener presionado',
      'showHelper_folders_title4': 'Agregar',
      'showHelper_folders_title5': 'Volver a la carpeta padre',
      'showHelper_folders_text1':
          'Haga clic en un elemento para ver sus propiedades.',
      'showHelper_folders_text2':
          'Haga doble clic en una carpeta para ver sus elementos.',
      'showHelper_folders_text3':
          'Mantenga presionado un elemento para bloquearlo / des-bloquearlo',
      'showHelper_folders_text4':
          'Agregue carpetas, imágenes, sonidos y videos.',
      'showHelper_folders_text5':
          'Para volver a la carpeta principal, presione este icono',
      'Show Help Screens': 'Mostrar pantallas de ayuda',
      'privacy policy': 'Política de privacidad',
      'must accept privacy policy':
          'Debe aceptar nuestra política de privacidad antes de continuar',
      'view privacy policy': 'Ver política de privacidad',
      'accept privacy policy': 'Aceptar la política de privacidad',
      'show hide schedule': 'Mostrar / ocultar horario',
      'show hide stories and schedule':
          'Mostrar u ocultar las historias y el horario.',
      'show': 'Mostrar',
      'hide': 'Esconder',
      'share item': 'Compartir',
      'check connection': 'Verifica la conexión',
      'not connected to internet': 'Parece que no estás conectado a Internet',
      'user information': 'Informacion del usuario',
      'settings restrictions instructions':
          'El acceso a la configuración puede restringirse. Esto es útil si el usuario intenta hacer clic en el icono de configuración distrayendose del proceso de aprendizaje. Al habilitarse la restriccion a la configuración se debe proporcionar la respuesta a un problema matemático simple. Si la respuesta es correcta, se otorgará acceso a la sección de configuración. Este mecanismo de restricción permite a los padres y maestros restringir el acceso a la seccion de configuración sin necesidad de recordar y compartir contraseñas.',
      'settings password protected': 'Restricciones de configuración',
      'settings password protected no': 'Sin restricciones',
      'settings password protected yes': 'Solicitar respuesta matemática',
      'delete linked device': 'Eliminar dispositivo vinculado',
      'confirm delete linked device':
          '¿Desea eliminar el dispositivo vinculado? Si lo elimina, deberá volver a vincularlo más tarde para volver a agregarlo.',
      'echo device': 'Este dispositivo hará eco de la caja de voz',
      'device silent': 'Este dispositivo permanecerá en silencio.',
      'device blocked': 'El dispositivo ahora está bloqueado.',
      'device unblocked': 'El dispositivo ha sido desbloqueado.',
      'output voicebox to device': 'Salida de caja de voz a otro dispositivo',
      'quizzes': 'Cuestionarios',
      'quizzes instructions':
          'Los cuestionarios se pueden crear (como profesor / educador) en este dispositivo (los cuestionarios se pueden responder en cualquier dispositivo)',
      'can create quiz': 'Puede crear cuestionario',
      'can not create quiz': 'No se puede crear un cuestionario.',
      'invite rejected': 'Invitación rechazada por',
      'invite sent': 'Invitación enviada a',
      'recieved invite': 'Has recibido una invitación para vincularte',
      'accept': 'Aceptar',
      'ignore and dismiss': 'Ignorar y despedir',
      'invite confirmed': 'Invitación confirmada a',
      'invite accepted': 'Invitación aceptada por',
      'remember link other party':
          'Recuerde: repita el mismo proceso en el otro dispositivo.',
      'please enter remote email':
          'Por favor ingrese el correo electrónico de la otra parte',
      'add new device': 'Agrega un nuevo dispositivo',
      'remote user email': 'Correo electrónico de usuario remoto',
      'remote user email instructions':
          'Para crear un enlace entre dos dispositivos, asegúrese de que ambos dispositivos estén encendidos, conectados a Internet, que la aplicación se esté ejecutando y que muestre la pantalla de dispositivos vinculados (esta pantalla). El establecimiento del enlace debe ejecutarse en ambos dispositivos (cada dispositivo debe ingresar el correo electrónico de la otra parte)',
      'enter remote user email':
          'Ingrese el correo electrónico del usuario remoto',
      'warning': 'Advertencia',
      'email or name not filled':
          'Correo electrónico o nombre no completado. Complete esta información antes de intentar vincular nuevos dispositivos.',
      'email or name required for backup':
          'Correo electrónico o nombre no completado. Complete esta información antes de intentar hacer una copia de seguridad del dispositivo.',
      'email or name required for restore':
          'Se requiere correo electrónico para restaurar',
      'start restore': 'Iniciar restauración',
      'replace folder': 'Reemplazar carpeta',
      'add to folder': 'Agregar a carpeta',
      'what to do with folder':
          'Seleccione la carpeta local que se reemplazará. Se sugiere hacer una copia de seguridad de este dispositivo antes de restaurar cualquier carpeta, ya que el contenido de la carpeta local se eliminará antes de reemplazarlo con la carpeta remota.',
      'choose folder to restore': 'Elija la carpeta para restaurar',
      'quiz': 'Examen',
      'linked devices': 'Dispositivos vinculados',
      'no linked devices': 'No se encontraron dispositivos vinculados',
      'change user name': 'Cambie el nombre de usuario',
      'confirm change user name': '¿Quieres cambiar el nombre del usuario?',
      'user name': 'Nombre de usuario',
      'user name hint': 'Ingrese el nombre del usuario',
      'change user email': 'Cambiar e-mail',
      'confirm change user email':
          'Si cambia el correo electrónico del usuario, deberá volver a vincular los dispositivos (el padre o el educador deberán volver a crear el enlace a este dispositivo). ¿Quieres continuar?',
      'user email': 'Correo electrónico del usuario',
      'user email instructions':
          'Ingrese el correo electrónico que utilizará el usuario. Puede ser el correo electrónico del padre si el usuario no tiene uno. No coloque el correo electrónico del educador o del maestro en este campo. El correo electrónico se utiliza para identificar como único cada usuario. El correo electrónico se utiliza para vincular dispositivos para sincronización o pruebas de conocimiento.',
      'user email hint': 'Ingrese correo electrónico',
      'toggle visibility for all':
          'Cambiar la visibilidad de todos los conceptos.',
      'item availability': 'Disponibilidad del artículo',
      'item availability instructions':
          'Si un artículo no está disponible, puede indicarlo. Los elementos no disponibles se mostrarán con una X roja sobre la imagen.',
      'is available': 'Está disponible',
      'is not available': 'No está disponible',
      'not available': 'No disponible',
      'available': 'Disponible',
      'delete story': 'Eliminar historia',
      'confirm delete story':
          '¿Estás seguro de que deseas eliminar la historia?',
      'level not enabled': 'Nivel no habilitado',
      'not enough data':
          'La escritura predictiva no está habilitada porque no se han reunido suficientes datos',
      'image size': 'Tamaño de la imagen',
      'text size': 'Tamaño del texto',
      'small': 'Pequeño',
      'medium': 'Medio',
      'large': 'Grande',
      'select video': 'Seleccionar video',
      'selected video': 'Video seleccionado:',
      'recording': 'Grabando...',
      'story object instructions':
          'Puede descartar conceptos deslizándolos. Nada será eliminado. (los conceptos solo se eliminan en el modo de edición)',
      'edit story name': 'Editar nombre de la historia',
      'select this concept': 'Selecciona este concepto',
      'no story object instructions': '',
      'add story object': 'Agregar concepto',
      'story name hint': 'Ingrese el nombre de la historia',
      'create new story': 'Crea una nueva historia',
      'no stories instructions':
          'Las historias le permiten unir conceptos (imágenes, sonidos y videos) para explicar nuevas ideas. Por ejemplo, puede explicar una visita al zoológico que comienza por ducharse, vestirse, desayunar, viajar en automóvil y ver a los animales.',
      'add story': 'Agregar historia',
      'please confirm': 'Por favor confirma',
      'replace sound confirmation': '¿Deseas reemplazar el audio existente?',
      'replace': 'Reemplazar',
      'voiceBoxSize': 'Tamaño de la caja de voz',
      'big': 'Grande',
      'select sound': 'Grabar audio',
      'select sound instructions':
          'Graba el sonido que deseas. Este audio se puede reproducir cuando el usuario hace clic en la imagen.',
      'delete': 'Borrar',
      'delete confirmation':
          'Confirme que desea eliminar este objeto. Esta operación es irreversible.',
      'warning not user created':
          'ADVERTENCIA: Este objeto se incluye de forma predeterminada con la APLICACIÓN. Si lo elimina, no hay forma de recuperarlo y debe agregarlo manualmente con su imagen y texto en cada idioma.',
      'folder not empty will not delete':
          'La carpeta debe estar vacía antes de eliminar',
      'local device': 'Dispositivo',
      'library': 'Biblioteca',
      'camara': 'Cámara',
      'folder should talk': 'Di el nombre de la carpeta',
      'folder should talk instructions':
          'Habilítelo si desea escuchar el nombre de la carpeta al hacer clic en ella.',
      'loading images': 'Cargando imagenes',
      'loading folders': 'Cargando carpetas',
      'loading relations': 'Cargando relaciones',
      'loading categories': 'Cargando categorías',
      'loading videos': 'Cargando videos',
      'loading sounds': 'Cargando sonidos',
      'allowLongPressInLearningScreen':
          'Permitir presionar un concepto en modo de aprendizaje',
      'long press instructions':
          'En el modo de aprendizaje, si el usuario mantiene presionado un concepto, se mostrará una pantalla que presenta información detallada de la opción seleccionada.',
      'Not assigned': 'Sin asignar',
      'nothing unlocked': 'Nada desbloqueado',
      'nothing unlocked instructions':
          'Antes de usar esta cuadrícula, debe seleccionar (mostrar / desbloquear) los conceptos que desee. Bloquee / desbloquee los conceptos manteniéndolos presionados. \n\nRecuerde que las carpetas no se muestran en este nivel.',
      'please unlock':
          'Desbloquee / haga visibles los elementos que desea en Configuración, Carpetas',
      'default folder': 'Carpeta por defecto',
      'open folders': 'Abrir carpetas',
      'default folder instructions':
          'Para seleccionar esta carpeta como carpeta predeterminada, haga clic en el botón',
      'understood': 'Entendido',
      'not understood': 'No entendido',
      'is understood': 'Se entiende el concepto',
      'is not understood': 'El concepto aún no se entiende.',
      'conceptIsUnderstood': 'Comprensión del concepto',
      'conceptIsUnderstoodInstructions':
          'Una vez que el usuario tenga el concepto claro, márquelo como entendido. Esto ayuda a los maestros y padres a comunicarse. Todos los conceptos entendidos se enmarcan en verde en la cuadrícula de aprendizaje.',
      'object visible': 'El objeto está actualmente visible',
      'object not visible': 'El objeto no está visible actualmente',
      'visibility': 'Visibilidad',
      'visibility instructions':
          'Muestra u oculta (desbloquea / bloquea) las imágenes que deseas',
      'image to show': 'Imagen a mostrar',
      'text to show': 'Texto a mostrar',
      'text to show instructions':
          'Este es el texto que se muestra debajo de cada imagen en la cuadrícula de aprendizaje.',
      'text to show hint': 'Ingrese el texto a mostrar',
      'text to say': 'Texto a decir',
      'text to say instructions':
          '¡Puedes cambiar qué decir! En lugar de decir "Mi nombre es ...", puedes cambiarlo a "Mi nombre es [ponga el nombre aquí]" o "Mi hermana es [nombre de la hermana]". También es útil tener un texto corto para mostrar pero un texto largo para decir, como cuando una imagen representa una frase larga.',
      'text to say hint': 'Ingrese el texto a decir',
      'edit': 'Editar',
      'no default folder': 'Carpeta predeterminada no seleccionada',
      'please select a default folder':
          'Selecciona una carpeta predeterminada. Solo se mostrarán las imágenes que haya desbloqueado de esa carpeta.',
      'select folder': 'Seleccionar carpeta predeterminada',
      'select a folder': 'Seleccione la carpeta remota que desea importar',
      'current default folder': 'Carpeta predeterminada actual:',
      'unlock': 'Desbloquear',
      'lock': 'Bloquear',
      'debug mode': 'Modo de depuración',
      'user profile': 'Ajustes de usuario',
      'add': 'Añadir',
      'Grid size': 'Tamaño de la cuadrícula',
      'grid size instructions':
          'Si lo desea, puede cambiar el tamaño de la cuadrícula (columnas y filas). Cambie esta configuración solo si tiene un dispositivo con una pantalla grande. Verifique que el usuario pueda ver y tocar cada icono cómodamente.',
      'operation completed successfully': 'La operación se realizó con éxito',
      'restore device': 'Restaurar dispositivo',
      'user email to restore': 'Correo electrónico de usuario a restaurar',
      'categories': 'Categorías',
      'category': 'Categoría',
      'close': 'Cerrar',
      'add folder': 'Agregar carpeta',
      'add image': 'Añadir imagen',
      'add empty': 'Agregar espacio vacío',
      'add video': 'Añadir video',
      'add sound': 'Añadir sonido',
      'new folder name': '',
      'new image name': '',
      'new video name': '',
      'new sound name': '',
      'show folder': 'Mostrar carpeta',
      'hide folder': 'Ocultar carpeta',
      'delete folder': 'Eliminar carpeta',
      'folder instructions':
          'Haga clic o doble clic en una imagen o un espacio vacío para activar sus opciones. Haga clic en el menú para explorar más opciones.',
      'grid instructions':
          'Dependiendo de las necesidades del usuario (para iconos más grandes) o del tamaño de la pantalla del dispositivo, puede cambiar el tamaño de la cuadrícula de las imágenes que se muestran a partir del nivel 5.',
      'grid': 'Cuadrícula',
      'Columns': 'Columnas',
      'Rows': 'Filas',
      'folders': 'Carpetas',
      'level not found': 'Nivel no encontrado',
      'missing reinforcer': 'Falta reforzador',
      'confirm reinforcer': 'Por favor confirme que quiere usar ',
      'selected reinforcer': 'Su refuerzo actual seleccionado es:',
      'please select a reinforcer': 'Selecciona un refuerzo para este nivel.',
      'cancel': 'Cancelar',
      'learn': 'Aprende',
      'stories': 'Historias',
      'schedule': 'Calendario',
      'help videos': 'Videos de ayuda',
      'images': 'Imágenes',
      'colors': 'Colores',
      'amber': 'Ámbar',
      'blue': 'Azul',
      'cyan': 'Cian',
      'deepOrange': 'Naranja intenso',
      'deepPurple': 'Morado oscuro',
      'green': 'Verde',
      'indigo': 'Índigo',
      'lightBlue': 'Azul claro',
      'lightGreen': 'Verde claro',
      'lime': 'Lima',
      'orange': 'Naranja',
      'pink': 'Rosado',
      'purple': 'Púrpura',
      'red': 'Rojo',
      'teal': 'Verde azulado',
      'yellow': 'Amarillo',
      'dark mode': 'Modo oscuro',
      'select this theme': 'Selecciona este tema',
      'select voice': 'Seleccionar voz',
      'no voice selected':
          'No hay voz seleccionada. Si no selecciona una voz, la aplicación no podrá decir ninguna palabra.',
      'tts': 'Texto a voz',
      'voice speed': 'Velocidad de la voz',
      'say': 'Dilo en voz alta',
      'send by email': 'Enviar por correo electrónico',
      'user name not configured': 'Nombre de usuario no configurado',
      'change': 'Cambiar',
      'no valid voice found': 'No se encontró una voz válida.',
      'test voice': 'Prueba de voz. Haga clic para activar.',
      'test text':
          'Si puede escuchar esta oración, ha configurado correctamente la voz.',
      'settings title': 'Ajustes',
      'levels': 'Niveles',
      'language': 'Idioma',
      'select language instructions': 'Selecciona tu idioma preferido',
      'Chinese': 'Chino',
      'English': 'Inglés',
      'Hindi': 'Hindi',
      'Spanish': 'Español',
      'Arabic': 'Árabe',
      'Malay': 'Malayo',
      'Russian': 'Ruso',
      'Bengali': 'Bengalí',
      'Portuguese': 'Portugués',
      'French': 'Francés',
      'German': 'Alemán',
      'find image': 'Buscar imagen',
      'selected level': 'Nivel seleccionado',
      'level1': 'Nivel 1',
      'level2': 'Nivel 2',
      'level3': 'Nivel 3',
      'level4': 'Nivel 4',
      'level5': 'Nivel 5',
      'level6': 'Nivel 6',
      'level7': 'Nivel 7',
      'level8': 'Nivel 8',
      'level9': 'Nivel 9',
      'level10': 'Nivel 10',
      'level11': 'Nivel 11',
      'change level': 'Cambiar nivel',
      'summary': 'Resumen',
      'level1 name': 'Reforzador',
      'level1 summary':
          'La función principal de este nivel es motivar al usuario a tocar la pantalla. El resultado de aprendizaje se logra cuando el usuario toca la pantalla de forma independiente para solicitar un objeto.',
      'Who does this level cater for': '¿A quién atiende este nivel?',
      'level1 Who does this level cater for':
          'Un niño o adulto con comunicación limitada a cero. La función principal de este nivel es alentar al usuario a sentirse motivado por la aplicación / dispositivo',
      'How do we achieve this?': '¿Cómo logramos esto?',
      'level1 How do we achieve this':
          'El padre / maestro / especialista debe ser consciente del refuerzo del niño. Un refuerzo es un objeto o elemento que el usuario disfruta o está obsesionado. Un buen ejemplo de esto sería un alimento, como el chocolate.',
      'select reinforcer': 'Seleccionar reforzador',
      'How do we get the user to touch the screen?':
          '¿Cómo hacemos que el usuario toque la pantalla?',
      'level1 How do we get the user to touch the screen':
          'El nivel 1 se configura como una pantalla / botón que habla tan pronto como se toca. Usando el ejemplo del chocolate, un padre / maestro / especialista debe configurar la aplicación para mostrar la imagen del chocolate. El padre / maestro / especialista DEBE estar preparado durante cada sesión de enseñanza al tener muchos trozos pequeños de chocolate que pueden proporcionar una recompensa instantánea al usuario. Recuerde, es importante reservar tiempo para las sesiones de enseñanza, pero cada momento del día puede ser una oportunidad de enseñanza. Tenga el iPad en un lugar donde el usuario pueda tener todas las oportunidades para usarlo. \n\nDurante su sesión de enseñanza \n1. Ofrezca un pequeño trozo de chocolate al usuario. Es mejor tener al Usuario sentado, aunque esto no siempre es posible. \n2. Use "mano sobre mano" para alentar al Usuario a tocar la pantalla. "Mano sobre mano" es un enfoque de enseñanza utilizado con niños autistas. El padre / maestro / especialista ayuda al usuario animándolo a presionar el botón. El padre / maestro / especialista coloca su mano sobre la mano del Usuario y los dirige hacia el botón seleccionado. * \n3. Tan pronto como la aplicación hable, el padre / maestro / especialista debe darle el chocolate al usuario al instante. \n4. Esto debe repetirse regularmente durante un período de hasta 5 minutos, a menos que el usuario se sienta frustrado. No le proporcione chocolate al Usuario hasta que haya presionado el botón, independientemente de lo frustrados que estén. \n5. Si el usuario se frustra, no te rindas. Este es un proceso largo, pero las ganancias a largo plazo configurarán al Usuario de por vida. Deténgase y vuelva a visitar esta tarea cuando el usuario esté tranquilo. \n\nRepita los pasos 1-5 a intervalos regulares durante el día. Muchos usuarios serán muy rápidos para tener éxito en este nivel y otros requerirán mucho trabajo, paciencia y esfuerzo. \n\n * La fuerza de esta asistencia debería reducirse gradualmente. Esto puede tomar meses para eliminar por completo.',
      'How do you know ready for level 2':
          '¿Cómo sabes que el usuario está listo para el nivel 2?',
      'level1 How do you know ready for level 2':
          'El usuario reducirá la necesidad de "mano a mano" cuando note que su hijo comienza a comprender que esta APLICACIÓN lo ayuda a obtener su refuerzo. Cuando el usuario presiona el botón de forma independiente y consistente, sin ningún apoyo del padre / maestro, el usuario está listo para el nivel 2',
      'level2 name': 'Opciones',
      'level2 summary':
          'Este nivel está diseñado para enseñarle al Usuario que hay más de una opción para un resultado gratificante. \n\nResultado del aprendizaje: el usuario tendrá la capacidad de solicitar ambos elementos de manera coherente y comprensiva.',
      'level2 Who does this level cater for':
          'Este nivel atiende a los usuarios que han accedido al nivel 1 y tienen una necesidad mínima de "mano a mano". El usuario progresa al ofrecerle dos opciones que lo alientan a tomar una decisión.',
      'level2 How do we achieve this':
          'El padre / maestro / especialista debe asegurarse de que la segunda imagen que se agrega a la pantalla sea un segundo refuerzo, por ejemplo, jugo. \n\nEl usuario ahora tendrá la opción de solicitar dos de sus artículos favoritos y esto construirá su relación con la aplicación.',
      'select second reinforcer': 'Seleccionar segundo refuerzo',
      'level2 How do we get the user to touch the screen':
          'El padre / maestro / especialista utilizará las mismas estrategias empleadas en el Nivel 1. En resumen, los dos elementos deben estar fácilmente disponibles y proporcionados al Usuario tan pronto como se solicite. \n\nEs importante asegurarse de que el usuario obtenga el elemento correcto y sea consciente de la diferencia en las dos imágenes. El usuario debe mostrar uno de los elementos y debe solicitarlo con precisión y coherencia. Los datos estarán disponibles para resaltar las respuestas y mostrar la precisión. \n\nEste nivel es uno de los niveles más rápidos para avanzar, ya que el usuario ya debería estar motivado por el reforzador de nivel 1.',
      'How do you know ready for level 3':
          '¿Cómo sabes que el usuario está listo para el nivel 3?',
      'level2 How do you know ready for level 3':
          'El usuario mostrará una mayor confianza en el uso de la aplicación de forma independiente y debería haber una necesidad limitada de "mano a mano". \n\nCuando el usuario presiona los botones de forma independiente y consistente, con un apoyo limitado de los padres / maestros / especialistas, esto es una señal de que el usuario está listo para el nivel 3.',
      'level3 name': 'Malas decisiones',
      'level3 summary':
          'En esta etapa, el usuario comprenderá que la aplicación proporciona un resultado que le proporciona placer. Es importante que se proporcione este nivel ya que esta progresión le enseña al Usuario que todas las opciones no son gratificantes sino que son comunicación. Este nivel se logra en un corto período de tiempo. \n\nResultado del aprendizaje: se debe observar que el usuario muestra disgusto al recibir la opción no preferida. El usuario ya no elegirá esta opción.',
      'level3 Who does this level cater for':
          'Este nivel atiende a los usuarios que han accedido a los niveles 1 y 2 y tienen una necesidad mínima / cero de "mano a mano". El usuario progresa al ofrecerle una tercera opción que no es una opción favorable.',
      'level3 How do we achieve this':
          'En esta etapa de desarrollo, el usuario ahora tendrá una opción no preferida. El padre / maestro / especialista debe asegurarse de que la tercera imagen que se agrega a la pantalla sea un elemento no preferido, por ejemplo, un calcetín. \n\nEl usuario ahora tendrá la opción de solicitar dos opciones preferidas y una opción no preferida.',
      'select third reinforcer': 'Seleccionar tercera palabra',
      'level3 How do we get the user to touch the screen':
          'El usuario ahora debe estar motivado por la aplicación y estará intrigado por tocar las imágenes. Han recibido placer de las imágenes hasta la fecha. El usuario será curioso y debería desear recibir un resultado positivo del artículo no preferido. Debe estar motivado sin el estímulo del padre / maestro / especialista; sin embargo, si este no es el caso, el padre / maestro / especialista debe seguir estrategias del Nivel 1 para fomentar esta interacción. \n\nSi el Usuario selecciona / toca cualquiera de las tres imágenes, recibirán el artículo al instante. Los primeros tres niveles están diseñados para enseñar al usuario cómo solicitar un artículo. Este nivel consolida el hecho de que no todas las opciones son agradables, son solicitudes. El usuario ahora aprenderá a considerar que las imágenes que toquen serán elementos que reciba, independientemente de si le gustan o no.',
      'How do you know ready for level 4':
          '¿Cómo sabes que el usuario está listo para el nivel 4?',
      'level3 How do you know ready for level 4':
          'El usuario mostrará decepción cuando reciba el artículo no preferido y continuará satisfecho con otros artículos solicitados. El padre / maestro / especialista debe continuar observando una mayor confianza en el uso de la aplicación de forma independiente. \n\nCuando el usuario presiona los botones de forma independiente y consistente, sin el apoyo de los padres / maestros / especialistas, el usuario está listo para el nivel 4. Los datos probarán estas observaciones. También se debe observar que el usuario muestra disgusto al recibir la opción no preferida. El usuario ya no elegirá esta opción.',
      'level4 name': 'Caja de voz',
      'level4 summary':
          'Este nivel está diseñado para comenzar a construir la estructura del lenguaje que se utilizará en los siguientes niveles. La recompensa para el Usuario solo se otorgará una vez que seleccione la imagen y toque el cuadro de voz. \n\nResultado del aprendizaje: El usuario seleccionará un elemento elegido y comprenderá que el elemento no se proporcionará hasta que ella / toca la caja de la voz.',
      'level4 Who does this level cater for':
          'Este nivel atiende a los usuarios que han accedido a los niveles 1-3 y ahora están utilizando la aplicación de forma independiente con un mínimo / cero "mano a mano". \n\nEste nivel es uno de los niveles más desafiantes para el padre / maestro / especialista y niveles frustrantes para el usuario. El objetivo de este nivel es enseñar al Usuario a usar una caja de voz que permita el desarrollo del lenguaje. En esta etapa, el padre / maestro / especialista está planeando desarrollar el lenguaje preparando al Usuario para usar el nivel de dos palabras, es decir. quiero chocolate Este nivel requiere tiempo y paciencia. Puede que sea necesario volver a "entregar una mano" durante un breve período de tiempo.',
      'level4 How do we achieve this':
          'En esta etapa, la pantalla de nivel 3 permanece con las mismas tres opciones, aunque la pantalla ahora tiene una tira larga en la parte superior de la pantalla. Esta tira se conoce como la "caja de voz". Cuando el usuario toca las imágenes habituales, la palabra ya no se pronunciará de inmediato. Ahora se mostrará en el cuadro de voz en la parte superior de la pantalla. El usuario ahora debe tocar el cuadro de voz para que se puedan pronunciar las palabras seleccionadas.',
      'level4 How do we get the user to touch the screen':
          'El usuario ya no recibirá una gratificación instantánea cuando se solicite el artículo. Se debe alentar a él / ella a tocar la caja de voz. Esto requerirá "mano a mano" para enseñar inicialmente al Usuario y mostrar lo que se espera. Todos los usuarios aprenderán esto a un ritmo diferente. El padre / maestro / especialista debe reducir gradualmente la "mano sobre mano" dependiendo de la comprensión del usuario.',
      'How do you know ready for level 5':
          '¿Cómo sabes que el usuario está listo para el nivel 5?',
      'level4 How do you know ready for level 5':
          'El usuario independientemente, o con el soporte de "mano sobre mano", seleccionará el elemento y tocará el cuadro de voz. Los datos mostrarán una alta tasa de éxito porcentual.',
      'level5 name': 'Construyendo vocabulario',
      'level 5 folders': 'Comportamiento de carpetas',
      'level 5 folder info':
          'Las carpetas no se muestran en este nivel. Esto es intencional para que el usuario no navegue a otras carpetas y se distraiga del objetivo del nivel.',
      'level5 summary':
          'Este nivel es el comienzo del proceso de enseñanza con el objetivo principal de construir un lenguaje para el usuario. \n\n Resultado del aprendizaje: el usuario tendrá una comprensión clara de 6 o más palabras dentro de una carpeta.',
      'level5 Who does this level cater for':
          'This level caters for Users who have accessed Levels 1-4. Users will generally be using the App independently at this stage although some may require ‘hand over hand’ support. \n\nThis level is the start of the teaching process with the primary aim being to build language for the User. The parent/teacher/specialist role becomes more important at this stage as new words should now be introduced to the User, and the parent/teacher/specialist must select words that would be important to the User. The words must also be within the same category ie. using the example of chocolate would require building language for snack items, and the snack items must be those preferred by the User. The categories have been pre-arranged into folders and the words can be made visible as required. If the words/items are not currently available on the folder, the parent/teacher/specialist can take a photo and add them in.\n\nAt this stage, the parent/teacher/specialist must follow the guidance that is provided in the teaching section regarding the use of videos, cards and items. This level takes time and a lot of patience. ‘Hand over hand’ may continue until the User builds his/her confidence.',
      'level5 How do we achieve this':
          'The Parent/Teacher/Specialist section within the App provides detail on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. \n\nThis section includes:\n1.	Continuing to request items\n2.	Matching pictures\n3.	Matching picture to object\n4.	Matching picture to item',
      'level5 How do we get the user to touch the screen':
          'This level requires the User to focus and remain seated to improve communication and build vocabulary. It is unlikely that the User will be willing to engage and therefore it is essential that the main reinforcer is re-introduced. The main reinforcer discussed as an example in the previous summaries was chocolate. In this case the chocolate must be readily available throughout these sessions as the User will be motivated to work if they are provided with a reward. \n\nInitially, the User should be rewarded with their reinforcer after EVERY successful item has been requested ie. when matching every item, the User should be rewarded with a small treat such as a third of a chocolate button. Gradually reduce the reinforcer treat as the User becomes more confident. In time, the User will no longer require a reinforcer. \n\For many this may require ‘hand over hand’ to initially teach the User and show what is expected. All Users will learn this at a different rate. The parent/teacher/specialist should gradually reduce the ‘hand over hand’ depending on the understanding of the User.',
      'How do you know ready for level 6':
          'How do you know the user is ready for level 6?',
      'level5 How do you know ready for level 6':
          'The User will have developed words within this category ie. snacks. This category will continue to be known as the ‘snack’ folder. When a folder contains 6 or more items the User is ready to progress to Level 6. The User would be expected to select items independently although some Users may still prefer ‘hand over hand’ support at this time. Data will continue to be available to show a high percentage success rate in identifying the chosen items. ',
      'level6 name': 'Creating folders',
      'level6 summary':
          'This Level allows Users to develop their language by increasing folders. Folders are created to allow Users to compartmentalize different topics ie. food, transport, clothes. \n\nLearning outcome: The User will show confidence in selecting items. They will be able to move between a minimum of three folders with ease.',
      'level6 Who does this level cater for':
          'This level differs from the others in that it caters for two groups:\n1.	Users who have accessed levels 1-5. These Users will be developing in confidence and most will be using the App independently. Some Users may still require extra support with ‘hand over hand’. Do not discourage this as all Users will develop at a different rate – as confidence grows, the need for support will reduce. \n2.	This would be the suggested stage to introduce the App to Users with limited/zero communication who are visual learners with moderate to good understanding. The parent/teacher/specialist should familiarize themselves with the teaching strategies employed in Levels 1-5 to promote maximum progress and understanding.\n\nThis Level allows Users to develop their language by increasing folders. Folders are created to allow Users to compartmentalize different topics ie. food, transport, clothes. \n\nThe Users who have accessed Levels 1-5 should be engaged and have a clear understanding of what is expected of them. This level allows the parent/teacher/specialist to add different folders to increase the language/speech opportunities. Consider this level as being similar language development for any individual learning a new language. Typical language development starts with one word ie. juice, cat, car. The words come from different folders. We, at Lucas Education, have created a template of folders that we believe are essential for day-to-day communication.',
      'level6 How do we achieve this':
          'One additional folder will be made available to the existing folder in Level 5. For new Users, two folders will be available. The parent/teacher/specialist selects a second folder which contains items that are motivating to the User. When data shows that the User has clearly understood 5 words, the App with allow the opportunity to unlock 5 more words within this folder as well as another folder. \n\nThis process will continue as your User continues to develop and grow. This is a natural process and the same process that all individuals go through when learning to speak and communicate. Level 6 is on-going learning and development.   \n\nThe Parent/Teacher/Specialist section within the App provides further detail on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. Games will be available in due course.\n\nThis section includes:\n1.	Continuing to request items\n2.	Matching pictures\n3.	Matching picture to object\n4.	Matching picture to item',
      'level6 How do we get the user to touch the screen':
          'This Level continues to require the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the program on the move. Examples of such opportunities are when seated in the car or maybe your child enjoys sitting in their pram.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be motivated to work if they are provided with a reward. It is important however to reduce the frequency of the reward. As the language develops, the reinforcer should be reduced and removed.  \n\nThis may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication.',
      'How do you know ready for level 7':
          'How do you know the user is ready for level 7?',
      'level6 How do you know ready for level 7':
          'The User will show confidence in selecting items. They will be able to move between a minimum of three folders with ease. Data will continue to be available to show a high percentage success rate in identifying the chosen items.',
      'level7 name': 'Sentence structure – part one',
      'level7 summary':
          'This Level allows Users to develop sentence structure by introducing a sentence starter. Folders are predesigned to predict possible sentence starters for each folder. \n\nLearning outcome: The User will show confidence in selecting the sentence starter followed by the chosen item. The words will be activated by pressing the voicebox.',
      'level7 Who does this level cater for':
          'This level caters for Users who have accessed Level 6.\n\nThis Level allows Users to develop sentence structure by introducing a sentence starter. Folders are predesigned to predict possible sentence starters for each folder. The option is also available to personalise words.',
      'level7 How do we achieve this':
          'In the previous section, typical language development was discussed. This section takes language development to the next level. Children move from one word level to two. We, at Lucas Education achieve this by introducing sentence starters which vary depending on the folder. Examples of this would be as follows:\n1.	Food folder – I want chocolate……I do not want chocolate.\n2.	Animal folder – I hear cat\n3.	Transport folder – I see car.\n\nSimilar to Level 4, the User may become frustrated during the initial stages of this Level as they are now expected to include a word prior to what has been expected of them in previous levels. For many reinforcers must be introduced again to ensure that the User remains motivated. \n\nAs with the previous folder the words/images will be released when data proves that the User is capable of understanding and consistently includes the sentence starter before requests. Level 7 is on-going learning and development.   \n\nThe Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources.',
      'level7 How do we get the user to touch the screen':
          'This Level also requires the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the programme on the move. Examples of such opportunities are when seated in the car or maybe your child enjoys sitting in their pram.\n\nOnce both icons, namely the sentence starter and the requested item, are appearing in the voice box, the User must touch the voice box and the App will say the sentence for example “I want chocolate” At this point the parent/teacher will give the User what he/she is requesting. The voice box should not be activated until an action and an image are added. Both icons must be spoken in the one voice box; they cannot be selected and spoken independently.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be more motivated to work if they are provided with a reward. This may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication. ',
      'How do you know ready for level 8':
          'How do you know the user is ready for level 8?',
      'level7 How do you know ready for level 8':
          'The User will show confidence in selecting the sentence starter followed by the chosen item. Data will continue to be available to show a high percentage success rate in identifying the chosen items and more sentence starters will be unlocked to develop language further.',
      'level8 name': 'Sentence structure – part two',
      'level8 summary':
          'This level caters for Users who have accessed Level 7.\n\nThis Level allows Users to develop sentence structure by including a sentence closer. Folders are predesigned to predict possible sentence closers for each folder. The option is also available to personalise words.',
      'level8 Who does this level cater for':
          'This level caters for Users who have accessed Level 7.\n\nThis Level allows Users to develop sentence structure by including a sentence closer. Folders are predesigned to predict possible sentence closers for each folder. The option is also available to personalise words.',
      'level8 How do we achieve this':
          'In Level 5, typical language development was promoted and in Level 6 the sentence starters were added. This Level progresses language development to the next level by closing the sentences. We, at Lucas Education achieve this by providing predicted sentence closers which vary depending on the folder. Examples of this would be as follows:\n1.	Food folder – I want chocolate please\n2.	Animal folder – I hear cat\n3.	Transport folder – I see car.\n\nThe final part of the sentences can or cannot be used in conjunction with the action and objects. For example in some cases, the closing part can be used alone eg. All done!\n\nSimilar to Levels 4 and 7, the User may become a little frustrated during the initial stages of this Level as they are now expected to include a word following what has been expected of them in previous levels. For many, reinforcers must be introduced again to ensure that the User remains motivated. \n\nAs with the previous folder the words/images will be released when data proves that the User is capable of understanding and consistently includes the sentence closer after requests. Level 8 is on-going learning and development.\n\The Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. ',
      'level8 How do we get the user to touch the screen':
          'This Level also requires the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the programme on the move. Such opportunities could be made possible at snack time or perhaps when ordering food at a takeaway.\n\nWhen all three icons, namely the sentence starter, the requested item and the sentence closer, are appearing in the voice box, the User must touch the voice box and the App will say the sentence, for example “I want chocolate, please!”. At this point the parent/teacher will give the person what she/he is requesting. The voice box should not be activated until an action, an image and a closer are added. All three icons must be spoken in the one voice box; they cannot be selected and spoken independently.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be more motivated to work if they are provided with a reward. This may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication.',
      'How do you know ready for level 9':
          'How do you know the user is ready for level 9?',
      'level8 How do you know ready for level 9':
          'The User will show confidence in selecting the sentence starter followed by the chosen item and sentence closer. Data will continue to be available to show a high percentage success rate in identifying the chosen items and more sentence closers will be unlocked to develop language further. \n\nUsers at this Level are now capable of accessing Levels 9, 10 and 11. All three Levels are challenging and cater for higher functioning Users. These Levels do not have to taught in a sequential order, for example, the User may find difficulty in progressing through Levels 9 and 10, but may succeed in Level 11.',
      'level9 name': 'Grammar and developed literacy',
      'level9 summary':
          'This Level allows higher functioning Users the opportunity to focus on building sentence structure by developing literacy through use of conjunctions, connectives and pronouns.\nThis is an important building block to teaching the User how to read. \n\nTHIS IS ONE OF THE MORE CHALLENGING LEVELS.\n\nLearning outcome: The User will have the ability to communicate with confidence by linking words with conjunctives and using other literacy cues to develop language further.',
      'level9 Who does this level cater for':
          'This level caters for Users who have accessed Level 8.\n\nThis Level allows higher functioning Users the opportunity to focus on building sentence structure by developing literacy through use of conjunctions, connectives and pronouns.\n\nTHIS IS ONE OF THE MORE CHALLENGING LEVELS.',
      'level9 How do we achieve this':
          'The Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. \n\nData will also assist in gathering success criteria and in unlocking progressive language.',
      'level9 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program. ',
      'How do you know ready for level 10':
          'How do you know the user is ready for level 10?',
      'level9 How do you know ready for level 10':
          'The User is capable to access Level 10 directly from Level 8. All Levels can be used at the same time to develop language. Words will be unlocked when data dictates that the User is ready. ',
      'level10 name': 'Learning words',
      'level10 summary':
          'This Level allows higher functioning Users the opportunity to focus on learning words as opposed to pictures. This Level progresses by removing pictures and replacing them with the name/text of each object. This is the initial step in providing our non-verbal children with the opportunity to read.\n\nLearning outcome: The User will have the ability to communicate with the same confidence by using words as opposed to images.',
      'level10 Who does this level cater for':
          'This level caters for Users who have accessed Level 8 or 9.\n\nThis Level allows higher functioning Users the opportunity to focus on learning words as opposed to pictures. Users who require images should bypass this Level and access Level 10.',
      'level10 How do we achieve this':
          'The Parent/Teacher/Specialist will have an understanding of the favourite words selected by the User. Data will also assist in gathering such details. All words have been set up to show a large image with a small defined word below (show example). The Parent/Teacher/Specialist will now gradually reduce the size of the picture for the favourite words, whilst increasing the size of the word. With time the Parent/Teacher/Specialist will aim to remove the image and only provide the User with the word. Once again, experience and data will provide feedback on the understanding of the User and their readiness to remove images from other buttons.',
      'level10 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program. If they are unable to use the words when the images have been reduced, this is a sign that the User is not ready for this Level and it must be revisited at another stage.',
      'How do you know ready for level 11':
          'How do you know the user is ready for level 11?',
      'level10 How do you know ready for level 11':
          'The User will show confidence in selecting icons with words as opposed to images. Data will continue to be available to show a high percentage success rate in identifying the chosen items.',
      'level11 name': 'predictive images/writing',
      'level11 summary':
          'This Level allows Users the opportunity to communicate with greater speed by providing the User with the opportunity to select predicted images or words. \n\nLearning outcome: The User will have the ability to communicate with the same confidence although at a greater speed and fluency.',
      'level11 Who does this level cater for':
          'This level caters for Users who have accessed Level 8.\n\nThis Level allows Users the opportunity to communicate with greater speed. ',
      'level11 How do we achieve this':
          'This Level provides the User with the opportunity to select predicted images or words. The App will provide a list of actions to be selected by the user. Once an action is selected, the pictures/words to be shown will be presented depending on the frequency of usage for each word. The most used words will appear higher in the grid while less used words for that specific action will appear lower on the grid.',
      'level11 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program',
    },
    // Arabic (422 million)
    'ar': {
      'app title': 'LUCAS',
      'relation': 'علاقة',
      'schedule day': 'جدولة اليوم',
      'sound': 'صوت',
      'video': 'فيديو',
      'story object': 'كائن القصة',
      'translation': 'ترجمة',
      'start': 'بدء النسخ الاحتياطي',
      'backup device': 'هذا الجهاز احتياطي',
      'Minimum level to show': 'أدنى مستوى للعرض',
      'background color': 'لون الخلفية',
      'loading empty spaces': 'تحميل المساحات الفارغة',
      'loading translations': 'تحميل الترجمات',
      'Drag and drop enabled': 'تمكين السحب والإفلات',
      'Drag and drop disabled': 'سحب وإسقاط تعطيل',
      'about this app': 'عن هذا التطبيق',
      'text to find': 'تجد',
      'text to find instructions':
          'أدخل كلمة أو جزء من الكلمة لتجدها في السؤال. اتركه فارغا للبحث عن الكل.',
      'number of concepts': 'عدد المفاهيم',
      'one concept': 'مفهوم واحد',
      'two concepts': 'مفهومان',
      'three or more': 'ثلاثة مفاهيم أو أكثر',
      'students': 'الطلاب',
      'find results': 'ابحث عن النتائج',
      'result is correct': 'النتيجة صحيحة',
      'result is wrong': 'النتيجة خاطئة',
      'play quiz': 'الاستماع إلى الاختبار',
      'silent quiz ongoing': 'الاختبار الصامت مستمر',
      'send to device': 'ارسل إلى:',
      'quiz type': 'نوع الاختبار',
      'quiz show image': 'عرض الصور',
      'quiz sound image': 'انطق المفاهيم',
      'quiz show sound and image': 'انطق المفاهيم واعرض الصور',
      'quiz do not show anything': 'لا تظهر أي شيء',
      'send quiz': 'إرسال الاختبار',
      'schedule_title1': 'أهلا بك',
      'schedule_title2': 'وقت اليوم',
      'schedule_title3': 'وضع التحرير',
      'schedule_title4': 'أضف كائن',
      'schedule_title5': 'إدارة الأيام',
      'schedule_text1':
          'يسمح الجدول الزمني بتصور الأشياء التي ستحدث. يسمح للمستخدم بفهم ما سيفعله اليوم وفي المستقبل. يمكنك الضغط لفترة طويلة على عنصر لرؤيته أكبر.',
      'schedule_text2': 'إخفاء / إظهار الوقت من اليوم الذي سيحدث فيه كل نشاط.',
      'schedule_text3':
          'يسمح وضع التحرير بإدارة المفاهيم. في وضع التحرير ، سيتم عرض جميع الأيام ويمكنك النقر فوق كل كائن للتفاعل معه.',
      'schedule_text4': 'حدد اليوم / الوقت والصورة التي تريد عرضها.',
      'schedule_text5': 'إذا كنت بحاجة إلى إضافة أيام جديدة ، انقر هنا.',
      'existing concept':
          'يوجد بالفعل مفهوم لنفس اليوم والساعة. يرجى تصحيح وإعادة المحاولة.',
      'please select an object': 'يرجى تحديد كائن',
      'please select a day': 'يرجى تحديد يوم',
      'select an object': 'حدد كائنًا',
      'add object': 'إضافة كائن للجدولة',
      'select day': 'حدد اليوم',
      'selected day': 'اليوم المحدد',
      'select hour': 'حدد الساعة',
      'monday': 'الإثنين',
      'tuesday': 'الثلاثاء',
      'wednesday': 'الأربعاء',
      'thursday': 'الخميس',
      'friday': 'يوم الجمعة',
      'saturday': 'يوم السبت',
      'sunday': 'الأحد',
      'school': 'مدرسة',
      'home': 'الصفحة الرئيسية',
      'today': 'اليوم',
      'tomorrow': 'غدا',
      'no action required title': 'لا يلزم اتخاذ أي إجراء',
      'no action required info':
          'يرجى قراءة المعلومات المقدمة والمتابعة بالضغط على أيقونة التعلم',
      'reset': 'إعادة تعيين',
      'video_title1': 'فيديو تمهيدي',
      'video_title2': 'المستوى 1',
      'video_title3': 'المستوي 2',
      'video_title4': 'مستوى 3',
      'video_title5': 'مستوى 4',
      'video_title6': 'مستوى 5',
      'video_title7': 'المستوى 6',
      'video_title8': 'المستوى 7',
      'video_title9': 'المستوى 8',
      'video_title10': 'المستوى 9',
      'video_title11': 'المستوى 10',
      'video_title12': 'المستوى 11',
      'video_title13': 'إعدادات المستخدم',
      'video_text1': 'الفيديو التمهيدي',
      'video_text2': 'فيديو معزز',
      'video_text3': 'اختيارات الفيديو',
      'video_text4': 'فيديو الخيارات السيئة',
      'video_text5': 'فيديو صندوق الصوت',
      'video_text6': 'بناء فيديو المفردات',
      'video_text7': 'إنشاء مجلدات فيديو',
      'video_text8': 'هيكل الجملة - الجزء الأول الفيديو',
      'video_text9': 'هيكل الجملة - الجزء الثاني فيديو',
      'video_text10': 'قواعد اللغة وتطوير الفيديو لمحو الأمية',
      'video_text11': 'فيديو تعلم الكلمات',
      'video_text12': 'صور تنبؤية / كتابة فيديو',
      'video_text13': 'فيديو إعدادات المستخدم',
      'showHelper_LevelSettings_title1': 'أول:',
      'showHelper_LevelSettings_title2': 'املأ المعلومات',
      'showHelper_LevelSettings_title3': 'مستوى التغيير',
      'showHelper_LevelSettings_title4': 'شاشة التعلم',
      'showHelper_LevelSettings_text1':
          'يرجى قراءة جميع المعلومات التي قدمناها لك',
      'showHelper_LevelSettings_text2':
          'تتطلب بعض المستويات معلومات من جانبك. تم تسليط الضوء عليها بشكل واضح',
      'showHelper_LevelSettings_text3':
          'إذا كنت بحاجة إلى تغيير المستويات ، يرجى القيام بذلك عن طريق الضغط على هذا الرمز',
      'showHelper_LevelSettings_text4':
          'بمجرد أن تصبح جاهزًا ، ارجع إلى شاشة التعلم',
      'showHelper_image-settings_title1': 'تجد',
      'showHelper_image-settings_title2': 'تعديل',
      'showHelper_image-settings_title3': 'حجم الشبكة',
      'showHelper_image-settings_title4': 'مساعدة',
      'showHelper_image-settings_text1':
          'أدخل النص واضغط على الزر للعثور على الصور',
      'showHelper_image-settings_text2': 'انقر على الصورة لتحريرها',
      'showHelper_image-settings_text3':
          'قم بتغيير حجم الشبكة بالضغط على هذا الزر',
      'showHelper_image-settings_text4':
          'تبديل المساعدة أو إيقاف تشغيلها باستخدام هذا الزر',
      'showHelper_folders_title1': 'انقر',
      'showHelper_folders_title2': 'نقرتين متتاليتين',
      'showHelper_folders_title3': 'ضغطة طويلة',
      'showHelper_folders_title4': 'أضف',
      'showHelper_folders_title5': 'العودة إلى المجلد الأصل',
      'showHelper_folders_text1': 'انقر فوق عنصر لعرض خصائصه',
      'showHelper_folders_text2': 'انقر نقرًا مزدوجًا فوق مجلد لعرض توابعه',
      'showHelper_folders_text3':
          'اضغط لفترة طويلة على عنصر لقفله / إلغاء قفله',
      'showHelper_folders_text4': 'أضف المجلدات والصور والأصوات والفيديو',
      'showHelper_folders_text5':
          'للعودة إلى المجلد الأصل ، اضغط على هذا الرمز',
      'Show Help Screens': 'إظهار شاشات التعليمات',
      'privacy policy': 'سياسة خاصة',
      'must accept privacy policy':
          'يجب عليك قبول سياسة الخصوصية الخاصة بنا قبل المتابعة',
      'view privacy policy': 'عرض سياسة الخصوصية',
      'accept privacy policy': 'قبول سياسة الخصوصية',
      'show hide schedule': 'إظهار / إخفاء الجدول الزمني',
      'show hide stories and schedule': 'إظهار أو إخفاء القصص والجدول الزمني',
      'show': 'تبين',
      'hide': 'إخفاء',
      'share item': 'شارك',
      'check connection': 'تحقق من اتصال',
      'not connected to internet': 'يبدو أنك غير متصل بالإنترنت',
      'user information': 'معلومات المستخدم',
      'settings restrictions instructions':
          'يمكن تقييد الوصول إلى التكوين. هذا مفيد إذا حاول المستخدم النقر على أيقونة التكوين ليصرف نفسه عن عملية التعلم. عند تمكين تقييد التكوين ، يجب توفير إجابة لمشكلة رياضية بسيطة. إذا كانت الإجابة صحيحة ، فسيتم منح الوصول إلى قسم التكوين. تتيح آلية التقييد هذه للآباء والمدرسين تقييد الوصول إلى قسم التكوين دون الحاجة إلى تذكر كلمات المرور ومشاركتها.',
      'settings password protected': 'قيود الإعدادات',
      'settings password protected no': 'لا قيود',
      'settings password protected yes': 'طلب إجابة الرياضيات',
      'delete linked device': 'حذف الجهاز المرتبط',
      'confirm delete linked device':
          'هل تريد حذف الجهاز المرتبط؟ إذا قمت بحذفها ، فستحتاج إلى إعادة ربطها لاحقًا لإضافتها مرة أخرى.',
      'echo device': 'هذا الجهاز سوف يردد صندوق الصوت',
      'device silent': 'سيبقى هذا الجهاز صامتا',
      'device blocked': 'تم حظر الجهاز الآن.',
      'device unblocked': 'تم إلغاء قفل الجهاز.',
      'output voicebox to device': 'مربع إخراج الصوت إلى جهاز آخر',
      'quizzes': 'الإختبارات',
      'quizzes instructions':
          'يمكن إنشاء الاختبارات (كمدرس / معلم) على هذا الجهاز (يمكن الرد على الاختبارات على أي جهاز)',
      'can create quiz': 'يمكن أن تخلق مسابقة',
      'can not create quiz': 'لا يمكن إنشاء مسابقة',
      'invite rejected': 'دعوة مرفوضة من قبل',
      'invite sent': 'دعوة أرسلت إلى',
      'recieved invite': 'لقد تلقيت دعوة للربط مع',
      'accept': 'قبول',
      'ignore and dismiss': 'تجاهل ورفض',
      'invite confirmed': 'تم تأكيد الدعوة إلى',
      'invite accepted': 'دعوة مقبولة من قبل',
      'remember link other party': 'تذكر: كرر نفس العملية على الجهاز الآخر.',
      'please enter remote email': 'الرجاء إدخال بريد الطرف الآخر',
      'add new device': 'إضافة جهاز جديد',
      'remote user email': 'البريد الإلكتروني للمستخدم عن بعد',
      'remote user email instructions':
          'لإنشاء رابط بين جهازين ، تأكد من تشغيل كلا الجهازين ، وأنهما متصلان بالإنترنت ، وأن يكون التطبيق قيد التشغيل ويعرض شاشة الأجهزة المرتبطة (هذه الشاشة). يجب تنفيذ إنشاء الرابط على كلا الجهازين (يجب أن يدخل كل جهاز في بريد الطرف الآخر)',
      'enter remote user email': 'أدخل البريد الإلكتروني للمستخدم البعيد',
      'warning': 'تحذير',
      'email or name not filled':
          'البريد الإلكتروني أو الاسم غير مملوء. يرجى استكمال هذه المعلومات قبل محاولة ربط الأجهزة الجديدة.',
      'email or name required for backup':
          'لم يتم ملء البريد الإلكتروني أو الاسم. يرجى إكمال هذه المعلومات قبل محاولة النسخ الاحتياطي للجهاز.',
      'email or name required for restore': 'البريد الإلكتروني مطلوب للاستعادة',
      'start restore': 'ابدأ الاستعادة',
      'replace folder': 'استبدل المجلد',
      'add to folder': 'أضف إلى المجلد',
      'what to do with folder':
          'حدد المجلد المحلي الذي سيتم استبداله. يُقترح إجراء نسخ احتياطي لهذا الجهاز قبل استعادة أي مجلد حيث سيتم حذف محتوى المجلد المحلي قبل استبداله بالمجلد البعيد.',
      'choose folder to restore': 'اختر مجلدًا لاستعادته',
      'quiz': 'امتحان',
      'linked devices': 'الأجهزة المرتبطة',
      'no linked devices': 'لا توجد أجهزة مرتبطة حيث تم العثور عليها',
      'change user name': 'غير اسم المستخدم',
      'confirm change user name': 'هل تريد تغيير اسم المستخدم؟',
      'user name': 'اسم المستخدم',
      'user name hint': 'أدخل اسم المستخدم',
      'change user email': 'تغيير البريد الالكتروني',
      'confirm change user email':
          'إذا قمت بتغيير بريد المستخدم الإلكتروني ، فستحتاج إلى إعادة ربط الأجهزة (سيحتاج الوالد أو المعلم إلى إعادة إنشاء الرابط إلى هذا الجهاز). هل تريد الاستمرار؟',
      'user email': 'البريد الإلكتروني للمستخدم',
      'user email instructions':
          'أدخل البريد الإلكتروني ليستخدمه المستخدم. يمكن أن يكون البريد الإلكتروني للوالدين إذا لم يكن لدى المستخدم واحد. لا تضع البريد الإلكتروني للمعلم أو المعلم في هذا المجال. يتم استخدام البريد الإلكتروني لتحديد فريدة لكل مستخدم. يتم استخدام البريد الإلكتروني لربط الأجهزة للمزامنة أو الاختبارات.',
      'user email hint': 'أدخل البريد الإلكتروني',
      'toggle visibility for all': 'تغيير وضوح جميع المفاهيم',
      'item availability': 'توافر البند',
      'item availability instructions':
          'إذا كان العنصر غير متوفر ، يمكنك الإشارة إليه. سيتم عرض العناصر غير المتاحة بعلامة X حمراء فوق الصورة',
      'is available': 'متاح',
      'is not available': 'غير متاح',
      'not available': 'غير متاح',
      'available': 'متاح',
      'delete story': 'حذف القصة',
      'confirm delete story': 'هل أنت متأكد أنك تريد حذف القصة؟',
      'level not enabled': 'المستوى غير ممكن',
      'not enough data':
          'لم يتم تمكين الكتابة التنبؤية لأنه لم يتم جمع بيانات كافية',
      'image size': 'حجم الصورة',
      'text size': 'حجم الخط',
      'small': 'صغير',
      'medium': 'متوسط',
      'large': 'كبير',
      'select video': 'اختر الفيديو',
      'selected video': 'فيديو محدد:',
      'recording': 'تسجيل...',
      'story object instructions':
          'يمكنك استبعاد المفاهيم عن طريق تمريرها. لن يتم حذف أي شيء. (يتم حذف المفاهيم فقط في وضع التحرير)',
      'edit story name': 'تحرير اسم القصة',
      'select this concept': 'حدد هذا المفهوم',
      'no story object instructions': '',
      'add story object': 'إضافة مفهوم',
      'story name hint': 'أدخل اسم القصة',
      'create new story': 'اصنع قصة جديدة',
      'no stories instructions':
          'تتيح لك القصص الانضمام إلى المفاهيم (الصور والأصوات ومقاطع الفيديو) لشرح الأفكار الجديدة. على سبيل المثال ، يمكنك شرح زيارة حديقة الحيوان التي تبدأ بالاستحمام وارتداء الملابس وتناول وجبة الإفطار والسفر بالسيارة ورؤية الحيوانات.',
      'add story': 'أضف قصة',
      'please confirm': 'يرجى تأكيد',
      'replace sound confirmation': 'هل تريد استبدال الصوت الموجود؟',
      'replace': 'يحل محل',
      'voiceBoxSize': 'حجم مربع الصوت',
      'big': 'كبير',
      'select sound': 'تسجيل صوتي',
      'select sound instructions':
          'تسجيل الصوت الذي تريده. يمكن تشغيل هذا الصوت عندما ينقر المستخدم على الصورة.',
      'delete': 'حذف',
      'delete confirmation':
          'يرجى تأكيد رغبتك في حذف هذا الكائن. هذه العملية لا رجعة فيها.',
      'warning not user created':
          'تحذير: يتم تجميع هذا الكائن افتراضيًا مع التطبيق. إذا قمت بحذفه ، فلا توجد طريقة لاستعادته ويجب عليك إضافته يدويًا بصورته ونصه في كل لغة.',
      'folder not empty will not delete': 'يجب أن يكون المجلد فارغًا قبل الحذف',
      'local device': 'جهاز',
      'library': 'مكتبة',
      'camara': 'الة تصوير',
      'folder should talk': 'قل اسم المجلد',
      'folder should talk instructions':
          'تمكين إذا كنت ترغب في سماع اسم المجلد عند النقر فوقه.',
      'loading images': 'تحميل الصور',
      'loading folders': 'تحميل المجلدات',
      'loading relations': 'تحميل العلاقات',
      'loading categories': 'تحميل الفئات',
      'loading videos': 'تحميل مقاطع الفيديو',
      'loading sounds': 'تحميل الأصوات',
      'allowLongPressInLearningScreen':
          'السماح لفترة طويلة الضغط على مفهوم في وضع التعلم',
      'long press instructions':
          'في وضع التعلم ، إذا ضغط المستخدم لفترة طويلة على أحد المفاهيم ، فستظهر شاشة تقدم معلومات مفصلة عن الخيار المحدد.',
      'Not assigned': 'غيرمعتمد',
      'nothing unlocked': 'لا شيء مفتوح',
      'nothing unlocked instructions':
          'قبل استخدام هذه الشبكة ، يجب عليك تحديد (إظهار / إلغاء قفل) المفاهيم التي تريدها. قفل / فتح المفاهيم عن طريق الحفاظ عليها الضغط. تذكر أن المجلدات لا تظهر في هذا المستوى.',
      'please unlock':
          'يرجى فتح / جعل العناصر التي تريدها مرئية في التكوين والمجلدات',
      'default folder': 'المجلد الإفتراضىr',
      'open folders': 'افتح المجلدات',
      'default folder instructions':
          'لتحديد هذا المجلد كمجلد افتراضي ، انقر فوق الزر',
      'understood': 'فهم',
      'not understood': 'غير مفهوم',
      'is understood': 'مفهوم مفهوم',
      'is not understood': 'مفهوم ليست مفهومة بعد',
      'conceptIsUnderstood': 'مفهوم الفهم',
      'conceptIsUnderstoodInstructions':
          'بمجرد أن يكون لدى المستخدم مفهوم واضح ، قم بتمييزه على أنه مفهوم. هذا يساعد المعلمين وأولياء الأمور الت��اصل. جميع المفاهيم مفهومة باللون الأخضر في شبكة التعلم.',
      'object visible': 'الكائن مرئي حاليًا',
      'object not visible': 'الكائن غير مرئي حاليًا',
      'visibility': 'رؤية',
      'visibility instructions': 'إظهار أو إخفاء (فتح / قفل) الصور التي تريدها',
      'image to show': 'صورة لإظهارها',
      'text to show': 'النص لإظهار',
      'text to show instructions':
          'هذا هو النص الظاهر تحت كل صورة في شبكة التعلم.',
      'text to show hint': 'أدخل النص لإظهاره',
      'text to say': 'النص ليقول',
      'text to say instructions':
          'يمكنك تغيير ما تقوله! بدلاً من قول "اسمي ..." ، يمكنك تغييره إلى "اسمي [ضع الاسم هنا]" أو "أختي [اسم أخت]". من المفيد أيضًا أن يكون لديك نص قصير لعرضه ولكن نصًا طويلًا يمكن قوله ، مثل عندما تمثل الصورة عبارة طويلة.',
      'text to say hint': 'أدخل النص ليقول',
      'edit': 'تعديل',
      'no default folder': 'المجلد الافتراضي غير محدد',
      'please select a default folder':
          'حدد مجلد افتراضي. سيتم عرض الصور التي قمت بإلغاء تأمينها من هذا المجلد فقط.',
      'select folder': 'حدد المجلد الافتراضي',
      'select a folder': 'حدد المجلد البعيد الذي تريد استيراده',
      'current default folder': 'المجلد الافتراضي الحالي:',
      'unlock': 'الغاء القفل',
      'lock': 'قفل',
      'debug mode': 'وضع التصحيح',
      'user profile': 'إعدادات المستخدم',
      'add': 'إضافة',
      'Grid size': 'حجم الشبكة',
      'grid size instructions':
          'إذا كنت ترغب في ذلك ، يمكنك تغيير حجم الشبكة (الأعمدة والصفوف). قم بتغيير هذا الإعداد فقط إذا كان لديك جهاز بشاشة كبيرة. تحقق من قدرة المستخدم على رؤية كل أيقونة ولمسها بشكل مريح.',
      'operation completed successfully': 'إكمال العملية بنجاح',
      'restore device': 'استعادة الجهاز',
      'user email to restore': 'البريد الإلكتروني للمستخدم لاستعادة',
      'categories': 'التصنيفات',
      'category': 'الفئة',
      'close': 'قريب',
      'add folder': 'أضف المجلد',
      'add image': 'إضافة صورة',
      'add empty': 'أضف مساحة فارغة',
      'add video': 'أضف فيديو',
      'add sound': 'إضافة الصوت',
      'new folder name': '',
      'new image name': '',
      'new video name': '',
      'new sound name': '',
      'show folder': 'عرض المجلد',
      'hide folder': 'إخفاء المجلد',
      'delete folder': 'احذف المجلد',
      'folder instructions':
          'انقر أو انقر نقرًا مزدوجًا فوق صورة أو مساحة فارغة لتفعيل خياراتها. انقر على القائمة لاستكشاف المزيد من الخيارات.',
      'grid instructions':
          'اعتمادًا على احتياجات المستخدم (للأيقونات الأكبر حجمًا) أو حجم شاشة الجهاز ، يمكنك تغيير حجم شبكة الصور المعروضة بدءًا من المستوى 5.',
      'grid': 'جريد',
      'Columns': 'أعمدة',
      'Rows': 'الصفوف',
      'folders': 'المجلدات',
      'level not found': 'المستوى غير موجود',
      'missing reinforcer': 'معزز في عداد المفقودين',
      'confirm reinforcer': 'يرجى تأكيد أنك تريد استخدام ',
      'selected reinforcer': 'معززك الحالي المحدد هو:',
      'please select a reinforcer': 'يرجى اختيار معزز لهذا المستوى',
      'cancel': 'إلغاء',
      'learn': 'تعلم',
      'stories': 'قصص',
      'schedule': 'جدول',
      'help videos': 'فيديوهات المساعدة',
      'images': 'صور',
      'colors': 'الألوان',
      'amber': 'كهرمان',
      'blue': 'أزرق',
      'cyan': 'ازرق سماوي',
      'deepOrange': 'برتقالي عميق',
      'deepPurple': 'الأرجواني العميق',
      'green': 'أخضر',
      'indigo': 'اللون النيلي',
      'lightBlue': 'أزرق فاتح',
      'lightGreen': 'اخضر فاتح',
      'lime': 'جير',
      'orange': 'البرتقالي',
      'pink': 'زهري',
      'purple': 'أرجواني',
      'red': 'أحمر',
      'teal': 'بط نهري صغير',
      'yellow': 'الأصفر',
      'dark mode': 'وضع الظلام',
      'select this theme': 'حدد هذا الموضوع',
      'select voice': 'اختر الصوت',
      'no voice selected':
          'لم يتم اختيار صوت. إذا لم تختر صوتًا ، فلن يتمكن التطبيق من نطق أي كلمة.',
      'tts': 'النص إلى كلام',
      'voice speed': 'سرعة الصوت',
      'say': 'قل بصوت عالٍ',
      'send by email': 'ارسل بالبريد الإلكترونى',
      'user name not configured': 'اسم المستخدم غير مكون',
      'change': 'يتغيرون',
      'no valid voice found': 'لم يتم العثور على صوت صالح',
      'test voice': 'اختبار الصوت. انقر للتنشيط.',
      'test text':
          'إذا استطعت سماع هذه الجملة ، فعندئذ قمت بتكوين الصوت بشكل صحيح.',
      'settings title': 'ترتيب',
      'levels': 'مستويات',
      'language': 'لغة',
      'select language instructions': 'اختر لغتك المفضلة',
      'Chinese': 'صينى',
      'English': 'الإنجليزية',
      'Hindi': 'الهندية',
      'Spanish': 'الأسبانية',
      'Arabic': 'عربى',
      'Malay': 'لغة الملايو',
      'Russian': 'الروسية',
      'Bengali': 'بنغالي',
      'Portuguese': 'البرتغالية',
      'French': 'فرنسي',
      'German': 'ألمانية',
      'find image': 'البحث عن الصورة',
      'selected level': 'المستوى المحدد',
      'level1': 'المستوى 1',
      'level2': 'المستوي 2',
      'level3': 'مستوى 3',
      'level4': 'مستوى 4',
      'level5': 'مستوى 5',
      'level6': 'المستوى 6',
      'level7': 'المستوى 7',
      'level8': 'المستوى 8',
      'level9': 'المستوى 9',
      'level10': 'المستوى 10',
      'level11': 'المستوى 11',
      'change level': 'مستوى التغيير',
      'summary': 'ملخص',
      'level1 name': 'معزز',
      'level1 summary':
          'المستوى 1. تتمثل الوظيفة الأساسية لهذا المستوى في تحفيز المستخدم على لمس الشاشة. تتحقق نتيجة التعلم عندما يلمس المستخدم الشاشة بشكل مستقل لطلب كائن واحد.',
      'Who does this level cater for': 'من الذي يلبي هذا المستوى؟',
      'level1 Who does this level cater for':
          'طفل أو شخص بالغ مع اتصال محدود. تتمثل الوظيفة الأساسية لهذا المستوى في تشجيع المستخدم على تحفيزه بواسطة التطبيق / الجهاز',
      'How do we achieve this?': 'كيف يمكننا تحقيق ذلك؟',
      'level1 How do we achieve this':
          'يجب أن يكون الوالد / المعلم / المختص على دراية بمحفز الطف��. المُعزز هو كائن أو عنصر يتمتع به المستخدم أو يتم حجبه. وخير مثال على ذلك سيكون عنصر الغذاء ، مثل الشوكولاته.',
      'select reinforcer': 'اختر معزز',
      'How do we get the user to touch the screen?':
          'كيف نجعل المستخدم يلمس الشاشة؟',
      'level1 How do we get the user to touch the screen':
          'يتم إعداد المستوى 1 كشاشة / زر واحد يتحدث بمجرد لمسه. باستخدام مثال الشوكولاتة ، يجب على الوالد / المعلم / المتخصص إعداد التطبيق لإظهار صورة الشوكولاته. يجب إعداد الوالد / المعلم / المختص أثناء كل جلسة تدريس من خلال تناول العديد من قطع الشوكولاته الصغيرة التي يمكن أن توفر مكافأة فورية للمستخدم. تذكر أنه من المهم تخصيص وقت لجلسات التدريس ، ولكن يمكن أن تكون كل لحظة من اليوم فرصة للتدريس. ضع جهاز iPad في مكان يمكن للمستخدم أن يتاح له كل فرصة لاستخدامه. \n\n خلال جلسة التدريس \n1. تقديم قطعة صغيرة من الشوكولاته للمستخدم. من الأفضل أن يكون المستخدم جالسًا ، على الرغم من أن هذا قد لا يكون ممكنًا دائمًا. \n2. استخدم "تسليم اليدين" لتشجيع المستخدم على لمس الشاشة. "تسليم اليدين" هو منهج تعليمي يستخدم مع الأطفال المصابين بالتوحد. يساعد الوالد / المعلم / المختص المستخدم من خلال تشجيعه على الضغط على الزر. يضع الوالد / المعلم / المختص يده على يد المستخدم ويوجهها نحو الزر المحدد. * \n3. بمجرد أن يتحدث التطبيق ، يجب على الوالد / المعلم / المختص إعطاء الشوكولا للمستخدم على الفور. \n4. يجب تكرار هذا بانتظام لمدة تصل إلى 5 دقائق ما لم يكن المستخدم محبطًا. لا تزود المستخدم بالشيكولاتة حتى يتم الضغط على الزر ، بصرف النظر عن مدى إحباطه. \n5. إذا أصبح المستخدم محبطًا ، فلا تستسلم. هذه عملية طويلة ، ولكن المكاسب طويلة الأجل ستحدد المستخدم مدى الحياة. قم بإيقاف هذه المهمة وإعادة زيارتها عندما يكون المستخدم هادئًا. \n\n كرر الخطوات من 1 إلى 5 على فترات منتظمة طوال اليوم. سيكون الكثير من المستخدمين سريعين للغاية لتحقيق النجاح في هذا المستوى وسيأخذ آخرون الكثير من العمل الشاق والصبر والجهد. \n\n * يجب تقليل قوة هذه المساعدة تدريجياً. هذا قد يستغرق شهورا لإزالة كاملة.',
      'How do you know ready for level 2':
          'كيف تعرف أن المستخدم مستعد للمستوى 2؟',
      'level1 How do you know ready for level 2':
          'سيقلل المستخدم من الحاجة إلى "التسليم باليد" حيث تلاحظ أن طفلك يبدأ في فهم أن هذا التطبيق يساعدهم في الحصول على معززهم. عندما يقوم المستخدم بالضغط على الزر بشكل مستقل ومتسق ، دون أي دعم من الوالد / المعلم ، يكون المستخدم جاهزًا للمستوى 2',
      'level2 name': 'خيارات',
      'level2 summary':
          'تم تصميم هذا المستوى لتعليم المستخدم أن هناك أكثر من خيار واحد للحصول على نتيجة مجزية. نتائج التعلم: سيكون لدى المستخدم القدرة على طلب كلا العنصرين بشكل متسق وفهم.',
      'level2 Who does this level cater for':
          'يلبي هذا المستوى للمستخدمين الذين وصلوا إلى المستوى 1 ولديهم الحد الأدنى من الحاجة إلى "تسليم باليد". تقدم المستخدم من خلال عرض خيارين يشجعانه على الاختيار.',
      'level2 How do we achieve this':
          'يجب على الوالد / المعلم / الأخصائي التأكد من أن الصورة الثانية التي يتم إضافتها إلى الشاشة هي معزز ثاني ، على سبيل المثال ، عصير. سيكون لدى المستخدم الآن خيار طلب عنصرين من العناصر المفضلة لديهم وسيؤدي ذلك إلى بناء علاقتهم مع التطبيق.',
      'select second reinforcer': 'حدد المعزز الثاني',
      'level2 How do we get the user to touch the screen':
          'سيستخدم الوالد / المعلم / المختص نفس الاستراتيجيات المستخدمة في المستوى 1. باختصار ، يجب أن يكون البندين متاحين بسهولة وأن يتم تقديمهما إلى المستخدم بمجرد الطلب. من المهم التأكد من أن المستخدم يحصل على العنصر الصحيح ويدرك الفرق في الصورتين. يجب عرض المستخدم على أحد العناصر ويجب عليه طلب ذلك بدقة وثبات. ستكون البيانات متاحة لتسليط الضوء على الردود وإظهار الدقة. هذا المستوى هو أحد أسرع المستويات التي يجب التقدم إليها حيث يجب أن يكون الدافع للمستخدم بالفعل من خلال معزز المستوى الأول.',
      'How do you know ready for level 3':
          'كيف تعرف أن المستخدم مستعد للمستوى 3؟',
      'level2 How do you know ready for level 3':
          'سيُظهر المستخدم ثقة مُحسّنة في استخدام التطبيق بشكل مستقل ويجب أن تكون هناك حاجة محدودة لـ "تسليم باليد". عندما يقوم المستخدم بدفع الأزرار بشكل مستقل ومتسق ، مع دعم محدود من الوالد / المعلم / المتخصص ، فإن ذلك يعد علامة على أن المستخدم جاهز للمستوى 3.',
      'level3 name': 'اختيارات سيئة',
      'level3 summary':
          'في هذه المرحلة ، سيدرك المستخدم أن التطبيق يوفر نتائج تمنحه / تسعدها. من المهم أن يتم توفير هذا المستوى لأن هذا التقدم يعلم المستخدم أن جميع الخيارات ليست مجزية ولكنها عبارة عن اتصال. يتم تحقيق هذا المستوى في فترة قصيرة من الزمن. نتائج التعلم: يجب مراعاة المستخدم لإظهار الاستياء مع تلقي الخيار غير المفضل. لن يقوم المستخدم باختيار هذا الخيار.',
      'level3 Who does this level cater for':
          'يلبي هذا المستوى للمستخدمين الذين وصلوا إلى المستويين 1 و 2 ولديهم الحد الأدنى / صفر من "تسليم باليد". يتقدم المستخدم من خلال عرض خيار ثالث ليس خيارًا مناسبًا.',
      'level3 How do we achieve this':
          'في هذه المرحلة من التطوير ، سيكون لدى المستخدم الآن خيار غير مفضل. يجب على الوالد / المعلم / المتخصص التأكد من أن الصورة الثالثة التي تتم إضافتها إلى الشاشة هي عنصر غير م��ضل ، على سبيل المثال ، جورب. سيكون لدى المستخدم الآن خيار طلب خيارين مفضلين وخيار واحد غير مفضل.',
      'select third reinforcer': 'حدد الكلمة الثالثة',
      'level3 How do we get the user to touch the screen':
          'يجب الآن تحفيز المستخدم من خلال التطبيق وسيتم إثارة اهتمامه بلمس الصور. لقد تلقوا المتعة من الصور حتى الآن. سيكون المستخدم فضوليًا ويرغب في الحصول على نتيجة إيجابية من العنصر غير المفضل. يجب تحفيزه / تحفيزه دون تحفيز من الوالد / المعلم / المختص ، ولكن إذا لم يكن الأمر كذلك ، فينبغي على الوالد / المعلم / المختص اتباع الاستراتيجيات من المستوى 1 لتشجيع هذا التفاعل. إذا قام المستخدم بتحديد / لمس أي من الصور الثلاث ، فسيتلقى العنصر على الفور. تم تصميم المستويات الثلاثة الأولى لتعليم المستخدم كيفية طلب عنصر. يعزز هذا المستوى حقيقة أن الخيارات ليست كلها ممتعة ، إنها طلبات. سيتعلم المستخدم الآن مراعاة أن الصور التي يلمسها ستكون عناصر يتلقونها ، بغض النظر عما إذا كانوا يحبونها أم لا.',
      'How do you know ready for level 4':
          'كيف تعرف أن المستخدم مستعد للمستوى 4؟',
      'level3 How do you know ready for level 4':
          'سيظهر المستخدم خيبة أمل عند استلام العنصر غير المفضل وسيظل مسرورًا بالعناصر الأخرى المطلوبة. يجب على الوالد / المعلم / المتخصص الاستمرار في مراقبة الثقة المحسنة في استخدام التطبيق بشكل مستقل. عندما يقوم المستخدم بدفع الأزرار بشكل مستقل ومتسق ، دون أي دعم من الوالد / المعلم / المتخصص ، يكون المستخدم جاهزًا للمستوى 4. ستثبت البيانات هذه الملاحظات. يجب أيضًا ملاحظة المستخدم لإظهار الاستياء من خلال تلقي الخيار غير المفضل. لن يقوم المستخدم باختيار هذا الخيار.',
      'level4 name': 'صندوق صوت',
      'level4 summary':
          'تم تصميم هذا المستوى للبدء في بناء بنية اللغة التي سيتم استخدامها في المستويات التالية. لن يتم منح مكافأة المستخدم إلا بعد تحديد الصورة ولمسها في صندوق الصوت. مخرجات التعلم: سيختار المستخدم عنصرًا مختارًا وسيفهم أنه لن يتم توفير العنصر حتى يلمس مربع الصوت.',
      'level4 Who does this level cater for':
          'يلبي هذا المستوى للمستخدمين الذين وصلوا إلى المستويات 1-3 ويستخدمون الآن التطبيق بشكل مستقل مع الحد الأدنى / الصفر من الدعم "تسليم باليد". هذا المستوى هو أحد المستويات الأكثر تحديا للوالد / المعلم / المتخصص ومستويات محبطة للمستخدم. الهدف من هذا المستوى هو تعليم المستخدم استخدام مربع صوت يسمح بتطوير اللغة. في هذه المرحلة ، يخطط الوالد / المعلم / المتخصص لتطوير اللغة عن طريق إعداد المستخدم لاستخدام مستوى كلمتين أي. تريد الشوكولاته. هذا المستوى يستغرق وقتا وصبرا. قد يتطلب الأمر العودة إلى "التسليم باليد" لفترة قصيرة.',
      'level4 How do we achieve this':
          'في هذه المرحلة ، تظل شاشة المستوى 3 مع الخيارات الثلاثة نفسها على الرغم من أن الشاشة لديها الآن شريط طويل في الجزء العلوي من الشاشة. يشار إلى هذا الشريط باسم "صندوق الصوت". عندما يلمس المستخدم الصور المعتادة ، لن يتم نطق الكلمة على الفور. سيتم عرضه الآن في صندوق الصوت أعلى الشاشة. يجب على المستخدم الآن لمس مربع الصوت لتمكين الكلمات المحددة من التحدث.',
      'level4 How do we get the user to touch the screen':
          'لن يتلقى المستخدم إشباعًا فوريًا عند طلب العنصر. يجب تشجيعه على لمس صندوق الصوت. سيتطلب ذلك "تسليم يدوي" لتعليم المستخدم في البداية وإظهار ما هو متوقع. سيتعلم جميع المستخدمين هذا بمعدل مختلف. يجب على الوالد / المعلم / المختص أن يقلل تدريجيًا من "التسليم باليد" وفقًا لفهم المستخدم.',
      'How do you know ready for level 5':
          'كيف تعرف أن المستخدم مستعد للمستوى 5؟',
      'level4 How do you know ready for level 5':
          'سيقوم المستخدم بشكل مستقل أو بدعم "تسليم باليد" بتحديد العنصر ولمس صندوق الصوت. سوف تظهر البيانات نسبة نجاح عالية.',
      'level5 name': 'بناء المفردات اللغوية',
      'level 5 folders': 'سلوك المجلدات',
      'level 5 folder info':
          'لا تظهر المجلدات في هذا المستوى. هذا مقصود ، لذا لن ينتقل المستخدم إلى مجلدات أخرى ويصرف الانتباه عن هدف المستوى',
      'level5 summary':
          'هذا المستوى هو بداية عملية التدريس والهدف الأساسي هو بناء لغة للمستخدم. \n\n نتيجة التعلم: سيكون لدى المستخدم فهم واضح بست كلمات أو أكثر داخل مجلد واحد.',
      'level5 Who does this level cater for':
          'This level caters for Users who have accessed Levels 1-4. Users will generally be using the App independently at this stage although some may require ‘hand over hand’ support. \n\nThis level is the start of the teaching process with the primary aim being to build language for the User. The parent/teacher/specialist role becomes more important at this stage as new words should now be introduced to the User, and the parent/teacher/specialist must select words that would be important to the User. The words must also be within the same category ie. using the example of chocolate would require building language for snack items, and the snack items must be those preferred by the User. The categories have been pre-arranged into folders and the words can be made visible as required. If the words/items are not currently available on the folder, the parent/teacher/specialist can take a photo and add them in.\n\nAt this stage, the parent/teacher/specialist must follow the guidance that is provided in the teaching section regarding the use of videos, cards and items. This level takes time and a lot of patience. ‘Hand over hand’ may continue until the User builds his/her confidence.',
      'level5 How do we achieve this':
          'The Parent/Teacher/Specialist section within the App provides detail on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. \n\nThis section includes:\n1.	Continuing to request items\n2.	Matching pictures\n3.	Matching picture to object\n4.	Matching picture to item',
      'level5 How do we get the user to touch the screen':
          'This level requires the User to focus and remain seated to improve communication and build vocabulary. It is unlikely that the User will be willing to engage and therefore it is essential that the main reinforcer is re-introduced. The main reinforcer discussed as an example in the previous summaries was chocolate. In this case the chocolate must be readily available throughout these sessions as the User will be motivated to work if they are provided with a reward. \n\nInitially, the User should be rewarded with their reinforcer after EVERY successful item has been requested ie. when matching every item, the User should be rewarded with a small treat such as a third of a chocolate button. Gradually reduce the reinforcer treat as the User becomes more confident. In time, the User will no longer require a reinforcer. \n\For many this may require ‘hand over hand’ to initially teach the User and show what is expected. All Users will learn this at a different rate. The parent/teacher/specialist should gradually reduce the ‘hand over hand’ depending on the understanding of the User.',
      'How do you know ready for level 6':
          'How do you know the user is ready for level 6?',
      'level5 How do you know ready for level 6':
          'The User will have developed words within this category ie. snacks. This category will continue to be known as the ‘snack’ folder. When a folder contains 6 or more items the User is ready to progress to Level 6. The User would be expected to select items independently although some Users may still prefer ‘hand over hand’ support at this time. Data will continue to be available to show a high percentage success rate in identifying the chosen items. ',
      'level6 name': 'Creating folders',
      'level6 summary':
          'This Level allows Users to develop their language by increasing folders. Folders are created to allow Users to compartmentalize different topics ie. food, transport, clothes. \n\nLearning outcome: The User will show confidence in selecting items. They will be able to move between a minimum of three folders with ease.',
      'level6 Who does this level cater for':
          'This level differs from the others in that it caters for two groups:\n1.	Users who have accessed levels 1-5. These Users will be developing in confidence and most will be using the App independently. Some Users may still require extra support with ‘hand over hand’. Do not discourage this as all Users will develop at a different rate – as confidence grows, the need for support will reduce. \n2.	This would be the suggested stage to introduce the App to Users with limited/zero communication who are visual learners with moderate to good understanding. The parent/teacher/specialist should familiarize themselves with the teaching strategies employed in Levels 1-5 to promote maximum progress and understanding.\n\nThis Level allows Users to develop their language by increasing folders. Folders are created to allow Users to compartmentalize different topics ie. food, transport, clothes. \n\nThe Users who have accessed Levels 1-5 should be engaged and have a clear understanding of what is expected of them. This level allows the parent/teacher/specialist to add different folders to increase the language/speech opportunities. Consider this level as being similar language development for any individual learning a new language. Typical language development starts with one word ie. juice, cat, car. The words come from different folders. We, at Lucas Education, have created a template of folders that we believe are essential for day-to-day communication.',
      'level6 How do we achieve this':
          'One additional folder will be made available to the existing folder in Level 5. For new Users, two folders will be available. The parent/teacher/specialist selects a second folder which contains items that are motivating to the User. When data shows that the User has clearly understood 5 words, the App with allow the opportunity to unlock 5 more words within this folder as well as another folder. \n\nThis process will continue as your User continues to develop and grow. This is a natural process and the same process that all individuals go through when learning to speak and communicate. Level 6 is on-going learning and development.   \n\nThe Parent/Teacher/Specialist section within the App provides further detail on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. Games will be available in due course.\n\nThis section includes:\n1.	Continuing to request items\n2.	Matching pictures\n3.	Matching picture to object\n4.	Matching picture to item',
      'level6 How do we get the user to touch the screen':
          'This Level continues to require the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the program on the move. Examples of such opportunities are when seated in the car or maybe your child enjoys sitting in their pram.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be motivated to work if they are provided with a reward. It is important however to reduce the frequency of the reward. As the language develops, the reinforcer should be reduced and removed.  \n\nThis may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication.',
      'How do you know ready for level 7':
          'How do you know the user is ready for level 7?',
      'level6 How do you know ready for level 7':
          'The User will show confidence in selecting items. They will be able to move between a minimum of three folders with ease. Data will continue to be available to show a high percentage success rate in identifying the chosen items.',
      'level7 name': 'Sentence structure – part one',
      'level7 summary':
          'This Level allows Users to develop sentence structure by introducing a sentence starter. Folders are predesigned to predict possible sentence starters for each folder. \n\nLearning outcome: The User will show confidence in selecting the sentence starter followed by the chosen item. The words will be activated by pressing the voicebox.',
      'level7 Who does this level cater for':
          'This level caters for Users who have accessed Level 6.\n\nThis Level allows Users to develop sentence structure by introducing a sentence starter. Folders are predesigned to predict possible sentence starters for each folder. The option is also available to personalise words.',
      'level7 How do we achieve this':
          'In the previous section, typical language development was discussed. This section takes language development to the next level. Children move from one word level to two. We, at Lucas Education achieve this by introducing sentence starters which vary depending on the folder. Examples of this would be as follows:\n1.	Food folder – I want chocolate……I do not want chocolate.\n2.	Animal folder – I hear cat\n3.	Transport folder – I see car.\n\nSimilar to Level 4, the User may become frustrated during the initial stages of this Level as they are now expected to include a word prior to what has been expected of them in previous levels. For many reinforcers must be introduced again to ensure that the User remains motivated. \n\nAs with the previous folder the words/images will be released when data proves that the User is capable of understanding and consistently includes the sentence starter before requests. Level 7 is on-going learning and development.   \n\nThe Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources.',
      'level7 How do we get the user to touch the screen':
          'This Level also requires the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the programme on the move. Examples of such opportunities are when seated in the car or maybe your child enjoys sitting in their pram.\n\nOnce both icons, namely the sentence starter and the requested item, are appearing in the voice box, the User must touch the voice box and the App will say the sentence for example “I want chocolate” At this point the parent/teacher will give the User what he/she is requesting. The voice box should not be activated until an action and an image are added. Both icons must be spoken in the one voice box; they cannot be selected and spoken independently.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be more motivated to work if they are provided with a reward. This may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication. ',
      'How do you know ready for level 8':
          'How do you know the user is ready for level 8?',
      'level7 How do you know ready for level 8':
          'The User will show confidence in selecting the sentence starter followed by the chosen item. Data will continue to be available to show a high percentage success rate in identifying the chosen items and more sentence starters will be unlocked to develop language further.',
      'level8 name': 'Sentence structure – part two',
      'level8 summary':
          'This level caters for Users who have accessed Level 7.\n\nThis Level allows Users to develop sentence structure by including a sentence closer. Folders are predesigned to predict possible sentence closers for each folder. The option is also available to personalise words.',
      'level8 Who does this level cater for':
          'This level caters for Users who have accessed Level 7.\n\nThis Level allows Users to develop sentence structure by including a sentence closer. Folders are predesigned to predict possible sentence closers for each folder. The option is also available to personalise words.',
      'level8 How do we achieve this':
          'In Level 5, typical language development was promoted and in Level 6 the sentence starters were added. This Level progresses language development to the next level by closing the sentences. We, at Lucas Education achieve this by providing predicted sentence closers which vary depending on the folder. Examples of this would be as follows:\n1.	Food folder – I want chocolate please\n2.	Animal folder – I hear cat\n3.	Transport folder – I see car.\n\nThe final part of the sentences can or cannot be used in conjunction with the action and objects. For example in some cases, the closing part can be used alone eg. All done!\n\nSimilar to Levels 4 and 7, the User may become a little frustrated during the initial stages of this Level as they are now expected to include a word following what has been expected of them in previous levels. For many, reinforcers must be introduced again to ensure that the User remains motivated. \n\nAs with the previous folder the words/images will be released when data proves that the User is capable of understanding and consistently includes the sentence closer after requests. Level 8 is on-going learning and development.\n\The Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. ',
      'level8 How do we get the user to touch the screen':
          'This Level also requires the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the programme on the move. Such opportunities could be made possible at snack time or perhaps when ordering food at a takeaway.\n\nWhen all three icons, namely the sentence starter, the requested item and the sentence closer, are appearing in the voice box, the User must touch the voice box and the App will say the sentence, for example “I want chocolate, please!”. At this point the parent/teacher will give the person what she/he is requesting. The voice box should not be activated until an action, an image and a closer are added. All three icons must be spoken in the one voice box; they cannot be selected and spoken independently.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be more motivated to work if they are provided with a reward. This may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication.',
      'How do you know ready for level 9':
          'How do you know the user is ready for level 9?',
      'level8 How do you know ready for level 9':
          'The User will show confidence in selecting the sentence starter followed by the chosen item and sentence closer. Data will continue to be available to show a high percentage success rate in identifying the chosen items and more sentence closers will be unlocked to develop language further. \n\nUsers at this Level are now capable of accessing Levels 9, 10 and 11. All three Levels are challenging and cater for higher functioning Users. These Levels do not have to taught in a sequential order, for example, the User may find difficulty in progressing through Levels 9 and 10, but may succeed in Level 11.',
      'level9 name': 'Grammar and developed literacy',
      'level9 summary':
          'This Level allows higher functioning Users the opportunity to focus on building sentence structure by developing literacy through use of conjunctions, connectives and pronouns.\nThis is an important building block to teaching the User how to read. \n\nTHIS IS ONE OF THE MORE CHALLENGING LEVELS.\n\nLearning outcome: The User will have the ability to communicate with confidence by linking words with conjunctives and using other literacy cues to develop language further.',
      'level9 Who does this level cater for':
          'This level caters for Users who have accessed Level 8.\n\nThis Level allows higher functioning Users the opportunity to focus on building sentence structure by developing literacy through use of conjunctions, connectives and pronouns.\n\nTHIS IS ONE OF THE MORE CHALLENGING LEVELS.',
      'level9 How do we achieve this':
          'The Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. \n\nData will also assist in gathering success criteria and in unlocking progressive language.',
      'level9 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program. ',
      'How do you know ready for level 10':
          'How do you know the user is ready for level 10?',
      'level9 How do you know ready for level 10':
          'The User is capable to access Level 10 directly from Level 8. All Levels can be used at the same time to develop language. Words will be unlocked when data dictates that the User is ready. ',
      'level10 name': 'Learning words',
      'level10 summary':
          'This Level allows higher functioning Users the opportunity to focus on learning words as opposed to pictures. This Level progresses by removing pictures and replacing them with the name/text of each object. This is the initial step in providing our non-verbal children with the opportunity to read.\n\nLearning outcome: The User will have the ability to communicate with the same confidence by using words as opposed to images.',
      'level10 Who does this level cater for':
          'This level caters for Users who have accessed Level 8 or 9.\n\nThis Level allows higher functioning Users the opportunity to focus on learning words as opposed to pictures. Users who require images should bypass this Level and access Level 10.',
      'level10 How do we achieve this':
          'The Parent/Teacher/Specialist will have an understanding of the favourite words selected by the User. Data will also assist in gathering such details. All words have been set up to show a large image with a small defined word below (show example). The Parent/Teacher/Specialist will now gradually reduce the size of the picture for the favourite words, whilst increasing the size of the word. With time the Parent/Teacher/Specialist will aim to remove the image and only provide the User with the word. Once again, experience and data will provide feedback on the understanding of the User and their readiness to remove images from other buttons.',
      'level10 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program. If they are unable to use the words when the images have been reduced, this is a sign that the User is not ready for this Level and it must be revisited at another stage.',
      'How do you know ready for level 11':
          'How do you know the user is ready for level 11?',
      'level10 How do you know ready for level 11':
          'The User will show confidence in selecting icons with words as opposed to images. Data will continue to be available to show a high percentage success rate in identifying the chosen items.',
      'level11 name': 'predictive images/writing',
      'level11 summary':
          'This Level allows Users the opportunity to communicate with greater speed by providing the User with the opportunity to select predicted images or words. \n\nLearning outcome: The User will have the ability to communicate with the same confidence although at a greater speed and fluency.',
      'level11 Who does this level cater for':
          'This level caters for Users who have accessed Level 8.\n\nThis Level allows Users the opportunity to communicate with greater speed. ',
      'level11 How do we achieve this':
          'This Level provides the User with the opportunity to select predicted images or words. The App will provide a list of actions to be selected by the user. Once an action is selected, the pictures/words to be shown will be presented depending on the frequency of usage for each word. The most used words will appear higher in the grid while less used words for that specific action will appear lower on the grid.',
      'level11 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program',
    },
    // Malay (281 million)
    'ms': {
      'app title': 'LUCAS',
      'relation': 'Perhubungan',
      'schedule day': 'Jadual hari',
      'sound': 'Bunyi',
      'video': 'Video',
      'story object': 'Objek cerita',
      'translation': 'Terjemahan',
      'start': 'Mulakan sandaran',
      'backup device': 'Sandarkan peranti ini',
      'Minimum level to show': 'Tahap minimum untuk ditunjukkan',
      'background color': 'Warna latar belakang',
      'loading empty spaces': 'Memuatkan tempat kosong',
      'loading translations': 'Memuatkan terjemahan',
      'Drag and drop enabled': 'Seret dan lepas diaktifkan',
      'Drag and drop disabled': 'Seret dan lepas dilumpuhkan',
      'about this app': 'Mengenai Aplikasi ini',
      'text to find': 'Cari',
      'text to find instructions':
          'Masukkan perkataan atau bahagian perkataan untuk dijumpai dalam soalan. Biarkan kosong untuk mencari semua.',
      'number of concepts': 'Bilangan konsep',
      'one concept': 'Satu konsep',
      'two concepts': 'Dua konsep',
      'three or more': 'Tiga atau lebih konsep',
      'students': 'Pelajar',
      'find results': 'Cari hasil',
      'result is correct': 'Hasilnya betul',
      'result is wrong': 'Hasilnya salah',
      'play quiz': 'Dengarkan kuiz',
      'silent quiz ongoing': 'Kuiz senyap sedang berlangsung',
      'send to device': 'Hantar kepada:',
      'quiz type': 'Jenis kuiz',
      'quiz show image': 'Tunjukkan gambar',
      'quiz sound image': 'Ucapkan konsep',
      'quiz show sound and image': 'Ucapkan konsep dan tunjukkan gambar',
      'quiz do not show anything': 'Jangan menunjukkan apa-apa',
      'send quiz': 'Hantar kuiz',
      'schedule_title1': 'Selamat datang',
      'schedule_title2': 'Masa hari',
      'schedule_title3': 'Mod suntingan',
      'schedule_title4': 'Tambah objek',
      'schedule_title5': 'Urus hari',
      'schedule_text1':
          'Jadual tersebut memungkinkan untuk membayangkan perkara yang akan berlaku. Ini membolehkan pengguna anda memahami apa yang akan dilakukannya hari ini dan masa depan. Anda boleh lama menekan item untuk melihatnya lebih besar.',
      'schedule_text2':
          'Sembunyikan / tunjukkan waktu setiap aktiviti akan berlaku.',
      'schedule_text3':
          'Mod suntingan membolehkan mengurus konsep. Dalam mod edit, semua hari akan ditunjukkan dan anda boleh mengklik setiap objek untuk berinteraksi dengannya.',
      'schedule_text4':
          'Pilih hari / masa dan gambar yang anda mahu ditunjukkan.',
      'schedule_text5':
          'Sekiranya anda perlu menambah hari baru, klik di sini.',
      'existing concept':
          'Sudah ada konsep untuk hari dan jam yang sama. Sila betulkan dan cuba lagi.',
      'please select an object': 'Sila pilih objek',
      'please select a day': 'Sila pilih satu hari',
      'select an object': 'Pilih objek',
      'add object': 'Tambahkan objek ke jadual',
      'select day': 'Pilih hari',
      'selected day': 'Hari terpilih',
      'select hour': 'Pilih jam',
      'monday': 'Isnin',
      'tuesday': 'Selasa',
      'wednesday': 'Hari Rabu',
      'thursday': 'Khamis',
      'friday': 'Jumaat',
      'saturday': 'Sabtu',
      'sunday': 'Ahad',
      'school': 'Sekolah',
      'home': 'Rumah',
      'today': 'Hari ini',
      'tomorrow': 'Esok',
      'no action required title': 'Tidak diperlukan tindakan',
      'no action required info':
          'Sila baca maklumat yang diberikan dan teruskan dengan mengklik ikon Belajar',
      'reset': 'Tetapkan semula',
      'video_title1': 'Video pengenalan',
      'video_title2': 'Tahap 1',
      'video_title3': 'Tahap 2',
      'video_title4': 'Tahap 3',
      'video_title5': 'Tahap 4',
      'video_title6': 'Tahap 5',
      'video_title7': 'Tahap 6',
      'video_title8': 'Tahap 7',
      'video_title9': 'Tingkat 8',
      'video_title10': 'Tingkat 9',
      'video_title11': 'Tingkat 10',
      'video_title12': 'Tingkat 11',
      'video_title13': 'Tetapan pengguna',
      'video_text1': 'Video pengenalan kami',
      'video_text2': 'Video penguat',
      'video_text3': 'Video pilihan',
      'video_text4': 'Video pilihan yang tidak baik',
      'video_text5': 'Video kotak suara',
      'video_text6': 'Membina video perbendaharaan kata',
      'video_text7': 'Membuat video folder',
      'video_text8': 'Struktur ayat - bahagian pertama video',
      'video_text9': 'Struktur ayat - video bahagian dua',
      'video_text10': 'Video tatabahasa dan literasi yang dikembangkan',
      'video_text11': 'Video perkataan pembelajaran',
      'video_text12': 'Gambar ramalan / penulisan video',
      'video_text13': 'Video tetapan pengguna',
      'showHelper_LevelSettings_title1': 'Pertama:',
      'showHelper_LevelSettings_title2': 'Isi maklumat',
      'showHelper_LevelSettings_title3': 'Tukar tahap',
      'showHelper_LevelSettings_title4': 'Skrin pembelajaran',
      'showHelper_LevelSettings_text1':
          'Sila baca semua maklumat yang kami sediakan untuk anda',
      'showHelper_LevelSettings_text2':
          'Beberapa tahap memerlukan maklumat dari pihak anda. Mereka diserlahkan dengan jelas',
      'showHelper_LevelSettings_text3':
          'Sekiranya anda perlu mengubah level, lakukan dengan menekan ikon ini',
      'showHelper_LevelSettings_text4':
          'Setelah siap, kembali ke skrin Belajar',
      'showHelper_image-settings_title1': 'Cari',
      'showHelper_image-settings_title2': 'Edit',
      'showHelper_image-settings_title3': 'Saiz grid',
      'showHelper_image-settings_title4': 'Tolonglah',
      'showHelper_image-settings_text1':
          'Masukkan teks dan tekan butang untuk mencari gambar',
      'showHelper_image-settings_text2': 'Klik pada gambar untuk mengeditnya',
      'showHelper_image-settings_text3':
          'Tukar ukuran grid dengan menekan butang ini',
      'showHelper_image-settings_text4':
          'Hidupkan atau matikan bantuan menggunakan butang ini',
      'showHelper_folders_title1': 'Klik',
      'showHelper_folders_title2': 'Klik dua kali',
      'showHelper_folders_title3': 'Tekan lama',
      'showHelper_folders_title4': 'Tambah',
      'showHelper_folders_title5': 'Kembali ke folder induk',
      'showHelper_folders_text1': 'Klik pada item untuk melihat sifatnya',
      'showHelper_folders_text2':
          'Klik dua kali pada folder untuk melihat anak-anaknya',
      'showHelper_folders_text3':
          'Tekan lama item untuk mengunci / membuka kuncinya',
      'showHelper_folders_text4': 'Tambahkan folder, gambar, suara dan video',
      'showHelper_folders_text5':
          'Untuk kembali ke folder induk tekan ikon ini',
      'Show Help Screens': 'Tunjukkan Skrin Bantuan',
      'privacy policy': 'Dasar privasi',
      'must accept privacy policy':
          'Anda mesti menerima dasar privasi kami sebelum meneruskan',
      'view privacy policy': 'Lihat dasar privasi',
      'accept privacy policy': 'Terima dasar privasi',
      'show hide schedule': 'Tunjukkan / sembunyikan jadual',
      'show hide stories and schedule':
          'Tunjukkan atau sembunyikan cerita dan jadual',
      'show': 'Tunjukkan',
      'hide': 'Sembunyikan',
      'share item': 'Kongsi',
      'check connection': 'Periksa sambungan',
      'not connected to internet':
          'Sepertinya anda tidak disambungkan ke Internet',
      'user information': 'Maklumat pengguna',
      'settings restrictions instructions':
          'Akses kepada konfigurasi boleh disekat. Ini berguna jika pengguna cuba mengklik ikon konfigurasi yang mengganggu dirinya dari proses pembelajaran. Apabila sekatan konfigurasi diaktifkan, jawapan kepada masalah matematik mudah mesti disediakan. Jika jawapannya betul, akses kepada bahagian konfigurasi akan diberikan. Mekanisme sekatan ini membolehkan ibu bapa dan guru untuk menyekat akses ke bahagian konfigurasi tanpa perlu mengingat dan berkongsi kata laluan.',
      'settings password protected': 'Sekatan tetapan',
      'settings password protected no': 'Tiada sekatan',
      'settings password protected yes': 'Minta jawapan matematik',
      'delete linked device': 'Padamkan peranti yang dipautkan',
      'confirm delete linked device':
          'Adakah anda ingin memadam peranti yang dipautkan? Sekiranya anda memadamkannya, anda perlu memuat semulanya kemudian menambahnya semula.',
      'echo device': 'Peranti ini akan echo voicebox tersebut',
      'device silent': 'Peranti ini akan tetap diam',
      'device blocked': 'Peranti kini disekat.',
      'device unblocked': 'Peranti telah dibatalkan.',
      'output voicebox to device': 'Output kotak suara ke peranti lain',
      'quizzes': 'Kuiz',
      'quizzes instructions':
          'Kuiz boleh diwujudkan (sebagai guru / pendidik) pada peranti ini (kuiz boleh dijawab pada mana-mana peranti)',
      'can create quiz': 'Boleh membuat kuiz',
      'can not create quiz': 'Tidak boleh membuat kuiz',
      'invite rejected': 'Jemput ditolak oleh',
      'invite sent': 'Jemput dihantar ke',
      'recieved invite':
          'Anda telah menerima jemputan untuk dihubungkan dengan',
      'accept': 'Terima',
      'ignore and dismiss': 'Abaikan dan abaikan',
      'invite confirmed': 'Jemput disahkan kepada',
      'invite accepted': 'Jemput diterima oleh',
      'remember link other party':
          'Ingat: ulangi proses yang sama pada peranti lain.',
      'please enter remote email': 'Sila masukkan e-mel pihak lain',
      'add new device': 'Tambah peranti baru',
      'remote user email': 'E-mel pengguna jauh',
      'remote user email instructions':
          'Untuk membuat hubungan antara dua peranti, pastikan kedua-dua peranti dihidupkan, disambungkan ke internet, laksanakan APP dan tunjukkan skrin peranti yang dipautkan (skrin ini). Penubuhan pautan mesti dilaksanakan pada kedua-dua peranti (setiap peranti mesti memasukkan e-mel pihak lain)',
      'enter remote user email': 'Masukkan e-mel pengguna jauh',
      'warning': 'Amaran',
      'email or name not filled':
          'E-mel atau nama tidak diisi. Sila lengkapkan maklumat ini sebelum cuba menghubungkan peranti baru.',
      'email or name required for backup':
          'E-mel atau nama tidak diisi. Sila lengkapkan maklumat ini sebelum cuba membuat sandaran peranti.',
      'email or name required for restore': 'E-mel diperlukan untuk memulihkan',
      'start restore': 'Mula pulihkan',
      'replace folder': 'Ganti folder',
      'add to folder': 'Tambah ke folder',
      'what to do with folder':
          'Pilih folder tempatan yang akan diganti. Sebaiknya buat sandaran peranti ini sebelum memulihkan folder apa pun kerana kandungan folder tempatan akan dihapus sebelum menggantinya dengan folder jauh.',
      'choose folder to restore': 'Pilih folder untuk dipulihkan',
      'quiz': 'Peperiksaan',
      'linked devices': 'Peranti yang berkaitan',
      'no linked devices': 'Tiada peranti terpaut yang dijumpai',
      'change user name': 'Tukar nama pengguna',
      'confirm change user name': 'Adakah anda mahu menukar nama pengguna?',
      'user name': 'Nama pengguna',
      'user name hint': 'Masukkan nama pengguna',
      'change user email': 'Tukar emel',
      'confirm change user email':
          'Jika anda menukar e-mel pengguna, anda perlu memaut semula peranti (ibu bapa atau pendidik perlu mencipta semula pautan ke peranti ini). Adakah anda mahu meneruskan?',
      'user email': 'E-mel pengguna',
      'user email instructions':
          'Masukkan e-mel untuk digunakan oleh pengguna. Ia boleh menjadi e-mel ibu bapa jika pengguna tidak mempunyai satu. Jangan letak e-mel pendidik atau guru di bidang ini. E-mel ini digunakan untuk mengenal pasti sebagai unik setiap pengguna. E-mel ini digunakan untuk menghubungkan peranti untuk penyegerakan atau kuiz.',
      'user email hint': 'Masukkan email',
      'toggle visibility for all': 'Tukar keterlihatan semua konsep',
      'item availability': 'Ketersediaan barang',
      'item availability instructions':
          'Sekiranya item tidak tersedia, anda boleh menunjukkannya. Item tidak tersedia akan ditunjukkan dengan X merah di atas imej',
      'is available': 'Boleh didapati',
      'is not available': 'Tidak boleh didapati',
      'not available': 'Tidak boleh didapati',
      'available': 'Tersedia',
      'delete story': 'Padamkan cerita',
      'confirm delete story': 'Adakah anda pasti mahu memadamkan cerita itu?',
      'level not enabled': 'Tahap tidak didayakan',
      'not enough data':
          'Penulisan ramalan tidak didayakan kerana data tidak cukup telah dikumpulkan',
      'image size': 'Saiz gambar',
      'text size': 'Saiz teks',
      'small': 'Kecil',
      'medium': 'Sederhana',
      'large': 'Besar',
      'select video': 'Pilih video',
      'selected video': 'Video yang dipilih:',
      'recording': 'Merakam ...',
      'story object instructions':
          'Anda boleh menolak konsep dengan meleretnya. Tiada apa-apa yang akan dipadamkan. (konsep hanya dipadam dalam mod edit)',
      'edit story name': 'Edit nama cerita',
      'select this concept': 'Pilih konsep ini',
      'no story object instructions': '',
      'add story object': 'Tambah konsep',
      'story name hint': 'Masukkan nama cerita',
      'create new story': 'Buat cerita baru',
      'no stories instructions':
          'Cerita membolehkan anda menyertai konsep (imej, bunyi dan video) untuk menerangkan idea-idea baru. Sebagai contoh, anda boleh menerangkan lawatan ke zoo yang bermula dengan mandi, memakai pakaian, bersarapan, mengembara dengan kereta dan melihat haiwan.',
      'add story': 'Tambah cerita',
      'please confirm': 'Tolong sahkan',
      'replace sound confirmation':
          'Adakah anda mahu menggantikan audio sedia ada?',
      'replace': 'Gantikan',
      'voiceBoxSize': 'Saiz kotak suara',
      'big': 'Besar',
      'select sound': 'Rakam audio',
      'select sound instructions':
          'Catat bunyi yang anda mahu. Audio ini boleh dimainkan semula apabila pengguna mengklik pada imej.',
      'delete': 'Padam',
      'delete confirmation':
          'Sila sahkan bahawa anda ingin memadamkan objek ini. Operasi ini tidak dapat dipulihkan.',
      'warning not user created':
          'PERINGATAN: Objek ini digabungkan secara lalai dengan APP. Sekiranya anda menghapusnya tidak ada cara untuk memulihkannya dan anda mesti menambahkannya secara manual dengan gambar dan teksnya dalam setiap bahasa.',
      'folder not empty will not delete': 'Folder mesti kosong sebelum memadam',
      'local device': 'Peranti',
      'library': 'Perpustakaan',
      'camara': 'Kamera',
      'folder should talk': 'Katakan nama folder',
      'folder should talk instructions':
          'Dayakan jika anda mahu mendengar nama folder apabila mengklik padanya.',
      'loading images': 'Memuatkan imej',
      'loading folders': 'Memuatkan folder',
      'loading relations': 'Memuatkan hubungan',
      'loading categories': 'Memuatkan kategori',
      'loading videos': 'Memuatkan video',
      'loading sounds': 'Memuatkan bunyi',
      'allowLongPressInLearningScreen':
          'Sentiasa lama menekan konsep dalam mod pembelajaran',
      'long press instructions':
          'Dalam mod pembelajaran, jika pengguna akan lama menekan satu konsep, skrin akan ditunjukkan dengan menyampaikan maklumat terperinci mengenai pilihan yang dipilih.',
      'Not assigned': 'Tidak ditugaskan',
      'nothing unlocked': 'Tiada kunci dibuka',
      'nothing unlocked instructions':
          'Sebelum menggunakan grid ini, anda mesti memilih (tunjukkan / buka kunci) konsep yang anda mahukan. Kunci / buka kunci konsep dengan memastikan mereka ditekan. Ingat bahawa folder tidak ditunjukkan di peringkat ini.',
      'please unlock':
          'Sila buka kunci / membuat item yang anda mahu dalam Konfigurasi, Folder',
      'default folder': 'Folder lalai',
      'open folders': 'Buka folder',
      'default folder instructions':
          'Untuk memilih folder ini sebagai folder lalai, klik butang',
      'understood': 'Faham',
      'not understood': 'Tidak difahami',
      'is understood': 'Konsep difahami',
      'is not understood': 'Konsep belum lagi difahami',
      'conceptIsUnderstood': 'Pemahaman konsep',
      'conceptIsUnderstoodInstructions':
          'Sekali pengguna mempunyai konsep yang jelas, tandakan ia difahami. Ini membantu guru dan ibu bapa berkomunikasi. Semua konsep yang difahami dibingkai dalam hijau dalam grid pembelajaran.',
      'object visible': 'Objek pada masa ini kelihatan',
      'object not visible': 'Objek tidak dapat dilihat pada masa ini',
      'visibility': 'Keterlihatan',
      'visibility instructions':
          'Tunjukkan atau sembunyikan (buka kunci / kunci) imej yang anda inginkan',
      'image to show': 'Imej untuk dipaparkan',
      'text to show': 'Teks untuk dipaparkan',
      'text to show instructions':
          'Ini adalah teks yang ditunjukkan di bawah setiap imej dalam grid pembelajaran.',
      'text to show hint': 'Masukkan teks untuk dipaparkan',
      'text to say': 'Teks untuk mengatakan',
      'text to say instructions':
          'Anda boleh menukar apa yang hendak dikatakan! Daripada mengatakan "Nama saya ...", anda boleh mengubahnya kepada "Nama saya [meletakkan nama di sini]" atau "Kakak saya ialah [nama kakak perempuan]". Ia juga berguna untuk mempunyai teks pendek untuk dipaparkan tetapi teks panjang untuk mengatakan, seperti apabila imej mewakili frasa panjang.',
      'text to say hint': 'Masukkan teks untuk mengatakan',
      'edit': 'Edit',
      'no default folder': 'Folder lalai tidak dipilih',
      'please select a default folder':
          'Pilih folder lalai. Hanya imej yang anda buka kunci dari folder itu akan ditunjukkan.',
      'select folder': 'Pilih folder lalai',
      'select a folder': 'Pilih folder jauh yang ingin anda import',
      'current default folder': 'Folder lalai semasa:',
      'unlock': 'Buka kunci',
      'lock': 'Kunci',
      'debug mode': 'Mod debug',
      'user profile': 'Tetapan pengguna',
      'add': 'Tambah',
      'Grid size': 'Saiz grid',
      'grid size instructions':
          'Jika anda mahu, anda boleh menukar saiz grid (lajur dan baris). Ubah tetapan ini hanya jika anda mempunyai peranti dengan skrin besar. Sahkan bahawa pengguna boleh melihat dan menyentuh setiap ikon dengan selesa.',
      'operation completed successfully': 'Operasi berjaya berjaya',
      'restore device': 'Pulihkan peranti',
      'user email to restore': 'E-mel pengguna untuk dipulihkan',
      'categories': 'Kategori',
      'category': 'Kategori',
      'close': 'Tutup',
      'add folder': 'Tambah folder',
      'add image': 'Tambah imej',
      'add empty': 'Tambahkan ruang kosong',
      'add video': 'Tambah video',
      'add sound': 'Tambah bunyi',
      'new folder name': '',
      'new image name': '',
      'new video name': '',
      'new sound name': '',
      'show folder': 'Tunjukkan folder',
      'hide folder': 'Sembunyikan folder',
      'delete folder': 'Padamkan folder',
      'folder instructions':
          'Klik atau klik dua kali imej atau ruang kosong untuk mengaktifkannya. Klik pada menu untuk meneroka lebih banyak pilihan.',
      'grid instructions':
          'Bergantung kepada keperluan pengguna (untuk ikon yang lebih besar) atau saiz skrin peranti, Anda boleh menukar saiz grid imej yang ditunjukkan bermula dari level 5.',
      'grid': 'Grid',
      'Columns': 'Lajur',
      'Rows': 'Baris',
      'folders': 'Folder',
      'level not found': 'Tahap tidak dijumpai',
      'missing reinforcer': 'Penguat yang hilang',
      'confirm reinforcer': 'Sila sahkan bahawa anda mahu menggunakannya ',
      'selected reinforcer': 'Penguat kuasa semasa anda ialah:',
      'please select a reinforcer': 'Sila pilih penguat untuk tahap ini',
      'cancel': 'Batalkan',
      'learn': 'Belajar',
      'stories': 'Cerita',
      'schedule': 'Jadual',
      'help videos': 'Bantuan video',
      'images': 'Imej',
      'colors': 'Warna',
      'amber': 'Amber',
      'blue': 'Biru',
      'cyan': 'Cyan',
      'deepOrange': 'Jeruk yang mendalam',
      'deepPurple': 'Ungu gelap',
      'green': 'Hijau',
      'indigo': 'Indigo',
      'lightBlue': 'Biru muda',
      'lightGreen': 'Lampu hijau',
      'lime': 'Lime',
      'orange': 'Orange',
      'pink': 'Merah jambu',
      'purple': 'Ungu',
      'red': 'Merah',
      'teal': 'Teal',
      'yellow': 'Kuning',
      'dark mode': 'Mod gelap',
      'select this theme': 'Pilih tema ini',
      'select voice': 'Pilih suara',
      'no voice selected':
          'Tiada suara dipilih. Jika anda tidak memilih suara, APP tidak akan dapat mengatakan apa-apa perkataan.',
      'tts': 'Teks Ucapan',
      'voice speed': 'Kelajuan suara',
      'say': 'Katakan dengan kuat',
      'send by email': 'Hantar melalui emel',
      'user name not configured': 'Nama pengguna tidak dikonfigurasi',
      'change': 'Ubah',
      'no valid voice found': 'Tiada suara yang sah dijumpai',
      'test voice': 'Uji suara. Klik untuk mengaktifkan.',
      'test text':
          'Jika anda dapat mendengar ayat ini maka anda telah mengonfigurasi suara dengan betul.',
      'settings title': 'Konfigurasi',
      'levels': 'Tahap',
      'language': 'Bahasa',
      'select language instructions': 'Pilih bahasa pilihan anda',
      'Chinese': 'Cina',
      'English': 'Bahasa Inggeris',
      'Hindi': 'Hindi',
      'Spanish': 'Sepanyol',
      'Arabic': 'Bahasa Arab',
      'Malay': 'Melayu',
      'Russian': 'Rusia',
      'Bengali': 'Bengali',
      'Portuguese': 'Portugis',
      'French': 'Perancis',
      'German': 'Jerman',
      'find image': 'Cari imej',
      'selected level': 'Tahap yang dipilih',
      'level1': 'Tahap 1',
      'level2': 'Tahap 2',
      'level3': 'Tahap 3',
      'level4': 'Tahap 4',
      'level5': 'Tahap 5',
      'level6': 'Tahap 6',
      'level7': 'Tahap 7',
      'level8': 'Tahap 8',
      'level9': 'Tahap 9',
      'level10': 'Tahap 10',
      'level11': 'Tahap 11',
      'change level': 'Tukar tahap',
      'summary': 'Ringkasan',
      'level1 name': 'Reinforcer',
      'level1 summary':
          'Fungsi utama tahap ini adalah untuk memberi motivasi kepada pengguna untuk menyentuh skrin. Hasil pembelajaran dicapai apabila pengguna menyentuh skrin secara bebas untuk meminta satu objek.',
      'Who does this level cater for': 'Siapa yang memenuhi tahap ini?',
      'level1 Who does this level cater for':
          'Seorang kanak-kanak atau orang dewasa dengan komunikasi terhad kepada sifar. Fungsi utama tahap ini adalah untuk menggalakkan pengguna menjadi termotivasi oleh APP / peranti',
      'How do we achieve this?': 'Bagaimanakah kita mencapai ini?',
      'level1 How do we achieve this':
          'Ibu bapa / guru / pakar mestilah menyedari penguatkuasaan kanak-kanak tersebut. Penguat ialah objek atau item yang dikehendaki atau diminati pengguna. Contoh yang baik ini akan menjadi bahan makanan, seperti coklat.',
      'select reinforcer': 'Pilih penguat',
      'How do we get the user to touch the screen?':
          'Bagaimanakah kita dapat pengguna menyentuh skrin?',
      'level1 How do we get the user to touch the screen':
          'Tahap 1 ditetapkan sebagai satu skrin / butang yang bercakap sebaik sahaja ia disentuh. Menggunakan contoh coklat, ibu bapa / guru / pakar perlu menyediakan aplikasi untuk menunjukkan imej coklat. Ibu bapa / guru / pakar HARUS disediakan pada setiap sesi pengajaran dengan mempunyai banyak kepingan coklat yang dapat memberikan ganjaran segera kepada pengguna. Ingat, adalah penting untuk mengetepikan masa untuk sesi pengajaran, tetapi setiap saat boleh menjadi peluang mengajar. Mempunyai iPad di tempat di mana Pengguna boleh mempunyai setiap peluang untuk menggunakannya. \n\nDalam sesi pengajaran anda \n1. Menawarkan sebiji coklat kecil kepada pengguna. Ia adalah yang terbaik untuk mempunyai Pengguna yang duduk, walaupun ini mungkin tidak semestinya. \n2. Gunakan \'tangan ke tangan\' untuk menggalakkan pengguna menyentuh skrin. \'Tangan di tangan\' adalah pendekatan pengajaran yang digunakan dengan kanak-kanak autistik. Ibu bapa / guru / pakar membantu Pengguna dengan menggalakkan mereka untuk menekan butang tersebut. Ibu bapa / guru / pakar meletakkan tangan mereka ke tangan Pengguna dan mengarahkan mereka ke arah butang yang dipilih. * \n3. Sebaik sahaja APP bercakap, ibu bapa / guru / pakar mesti dengan serta-merta memberi coklat kepada Pengguna. \n4. Ini harus diulang secara berkala untuk tempoh sehingga 5 minit kecuali Pengguna menjadi kecewa. Jangan berikan Pengguna dengan coklat sehingga butang telah ditekan, tidak kira betapa kecewa mereka. \n5. Jika Pengguna menjadi kecewa, jangan berputus asa. Ini adalah proses yang panjang, tetapi keuntungan jangka panjang akan menetapkan Pengguna untuk hidup. Berhenti dan semak semula tugas ini apabila Pengguna menjadi tenang. \n\nMulakan semula langkah 1-5 pada selang masa biasa sepanjang hari. Ramai Pengguna akan sangat cepat untuk berjaya di peringkat ini dan yang lain akan mengambil banyak kerja keras, kesabaran dan usaha. \n\n * Kekuatan bantuan ini harus dikurangkan secara beransur-ansur. Ini mungkin mengambil masa beberapa bulan untuk dialih keluar sepenuhnya.',
      'How do you know ready for level 2':
          'Bagaimana anda tahu pengguna sedia untuk tahap 2?',
      'level1 How do you know ready for level 2':
          'Pengguna akan mengurangkan keperluan untuk "menyerahkan tangan" apabila anda melihat bahawa anak anda mula memahami APP ini membantu mereka mendapatkan penguat mereka. Apabila pengguna menekan butang secara bebas dan konsisten, tanpa sokongan daripada ibu bapa / guru, pengguna bersedia untuk level 2',
      'level2 name': 'Pilihan',
      'level2 summary':
          'Tahap ini direka untuk mengajar Pengguna bahawa terdapat lebih daripada satu pilihan untuk hasil yang memuaskan. \n\nPenggunaan pembelajaran: Pengguna akan mempunyai keupayaan untuk meminta kedua-dua item secara konsisten dan dengan pemahaman.',
      'level2 Who does this level cater for':
          'Tahap ini disediakan untuk Pengguna yang telah mengakses tahap 1 dan mempunyai keperluan minimum untuk \'tangan tangan\'. Pengguna berlangsung dengan menawarkan dua pilihan yang mendorong mereka untuk membuat pilihan.',
      'level2 How do we achieve this':
          'Ibu bapa / guru / pakar mesti memastikan bahawa imej kedua yang ditambahkan pada skrin adalah penguat kedua, sebagai contoh, jus. \n\nPengguna kini akan mempunyai pilihan untuk meminta dua item kegemaran mereka dan ini akan membina hubungan mereka dengan aplikasinya.',
      'select second reinforcer': 'Pilih penguat kedua',
      'level2 How do we get the user to touch the screen':
          'Ibu bapa / guru / pakar akan menggunakan strategi yang sama yang digunakan dalam Tahap 1. Sebagai ringkasan, kedua-dua item itu mestilah sedia dan disediakan kepada Pengguna sebaik sahaja diminta. \n\nIa adalah penting untuk memastikan Pengguna mendapat item yang betul dan menyedari perbezaan dalam kedua-dua imej. Pengguna harus ditunjukkan salah satu item dan harus meminta secara tepat dan konsisten. Data akan tersedia untuk menyerlahkan respons dan menunjukkan ketepatan. \n\nTingkat ini adalah salah satu daripada tahap terpantas untuk maju melalui sebagai pengguna seharusnya dimotivasi oleh penguat tahap 1.',
      'How do you know ready for level 3':
          'Bagaimana anda tahu pengguna sedia untuk tahap 3?',
      'level2 How do you know ready for level 3':
          'Pengguna akan menunjukkan keyakinan yang lebih baik dalam menggunakan Aplikasi secara berasingan dan keperluan terhad untuk \'tangan tangan\'. \n\nWhen User menekan butang secara bebas dan konsisten, dengan sokongan terhad dari ibu bapa / guru / pakar, ini adalah tanda bahawa Pengguna sudah siap untuk level 3.',
      'level3 name': 'Pilihan yang tidak baik',
      'level3 summary':
          'Pada peringkat ini Pengguna akan memahami bahawa App menyediakan hasil yang memberikannya / keseronokannya. Adalah penting bahawa tahap ini disediakan kerana kemajuan ini mengajar Pengguna bahawa semua pilihan tidak memberi ganjaran tetapi mereka adalah komunikasi. Tahap ini dicapai dalam masa yang singkat. \n\nMemelajari hasil: Pengguna harus diperhatikan untuk menunjukkan rasa tidak percaya dengan menerima pilihan yang tidak diutamakan. Pengguna tidak lagi akan memilih pilihan ini.',
      'level3 Who does this level cater for':
          'Tahap ini disediakan untuk Pengguna yang telah mengakses tahap 1 dan 2 dan mempunyai keperluan minimum / sifar untuk \'tangan ke tangan\'. Pengguna berlangsung melalui pilihan ketiga yang bukan pilihan yang baik.',
      'level3 How do we achieve this':
          'Pada peringkat pembangunan ini, Pengguna kini akan mempunyai pilihan yang tidak diutamakan. Ibu bapa / guru / pakar mesti memastikan bahawa imej ketiga yang ditambahkan pada skrin adalah item yang tidak disukai, contohnya, kaus kaki. \n\nPengguna kini akan mempunyai pilihan untuk meminta dua pilihan pilihan dan satu pilihan yang tidak disukai.',
      'select third reinforcer': 'Pilih perkataan ketiga',
      'level3 How do we get the user to touch the screen':
          'Pengguna kini harus termotivasi oleh App dan akan tertarik untuk menyentuh imej. Mereka telah mendapat keseronokan dari imej sehingga kini. Pengguna akan ingin tahu dan ingin mendapatkan hasil positif daripada item yang tidak disukai. Dia / dia seharusnya bermotivasi tanpa rangsangan daripada ibu bapa / guru / pakar, tetapi jika ini tidak demikian maka orangtua / guru / pakar harus mengikuti strategi dari Tahap 1 untuk menggalakkan interaksi ini. \n\nJika Pengguna memilih / menyentuh mana-mana tiga imej, mereka akan menerima item dengan serta-merta. Tiga peringkat pertama direka untuk mengajar pengguna bagaimana untuk meminta item. Tahap ini menggabungkan hakikat bahawa tidak semua pilihan yang menyenangkan, mereka adalah permintaan. Pengguna kini akan belajar untuk mempertimbangkan imej yang mereka sentuh akan menjadi perkara yang mereka terima, tidak kira sama ada mereka suka atau tidak.',
      'How do you know ready for level 4':
          'Bagaimana anda tahu pengguna sedia untuk tahap 4?',
      'level3 How do you know ready for level 4':
          'Pengguna akan menunjukkan kekecewaan apabila menerima item yang tidak diutamakan dan akan terus gembira dengan item lain yang diminta. Ibu bapa / guru / pakar harus terus memantau keyakinan yang lebih baik menggunakan App secara bebas. \n\nKetika Pengguna menekan butang secara bebas dan konsisten, tanpa sokongan daripada ibu bapa / guru / pakar, Pengguna bersedia untuk tahap 4. Data akan membuktikan pemerhatian ini. Pengguna juga harus diperhatikan untuk menunjukkan kebencian dengan menerima pilihan yang tidak diutamakan. Pengguna tidak lagi akan memilih pilihan ini.',
      'level4 name': 'Kotak suara',
      'level4 summary':
          'Tahap ini direka untuk memulakan membina struktur bahasa yang akan digunakan pada peringkat seterusnya. Ganjaran untuk Pengguna hanya akan diberikan apabila dia memilih imej dan menyentuh di kotak suara. \n\nHasil pembelajaran: Pengguna akan memilih item yang dipilih dan akan memahami bahawa item itu tidak akan diberikan sehingga dia / dia menyentuh kotak suara.',
      'level4 Who does this level cater for':
          'Tahap ini memenuhi syarat untuk Pengguna yang telah mengakses tahap 1-3 dan kini menggunakan App secara bebas dengan sokongan minimum / sifar \'tangan ke tangan\'. \n\nTingkat ini adalah salah satu daripada tahap yang lebih mencabar untuk peringkat ibu bapa / guru / pakar dan mengecewakan untuk Pengguna. Tujuan tahap ini adalah untuk mengajar Pengguna menggunakan kotak suara yang membolehkan pembangunan bahasa. Pada peringkat ini, ibu bapa / guru / pakar merancang untuk membangunkan bahasa dengan menyediakan Pengguna menggunakan tahap dua kata iaitu. mahu coklat. Tahap ini memerlukan masa dan kesabaran. Ia mungkin memerlukan kembali untuk \'menyerahkan tangan\' untuk masa yang singkat.',
      'level4 How do we achieve this':
          'Pada peringkat ini, skrin 3 tingkat kekal dengan tiga pilihan sama walaupun skrin kini mempunyai jalur panjang di bahagian atas skrin. Jalur ini dirujuk sebagai \'kotak suara\'. Apabila Pengguna menyentuh imej biasa, perkataan itu tidak akan lagi dituturkan dengan segera. Ia kini akan dipaparkan dalam kotak suara di bahagian atas skrin. Pengguna kini perlu menyentuh kotak suara untuk membolehkan kata-kata yang dipilih untuk dituturkan.',
      'level4 How do we get the user to touch the screen':
          'Pengguna tidak lagi akan menerima suapan segera apabila item tersebut diminta. Dia / dia mesti digalakkan untuk menyentuh kotak suara. Ini akan memerlukan \'menyerahkan tangan\' untuk mulanya mengajar Pengguna dan menunjukkan apa yang diharapkan. Semua Pengguna akan mempelajari ini pada kadar yang berbeza. Ibu bapa / guru / pakar harus secara beransur-ansur mengurangkan \'tangan di tangan\' bergantung kepada pemahaman Pengguna.',
      'How do you know ready for level 5':
          'Bagaimana anda tahu pengguna sedia untuk tahap 5?',
      'level4 How do you know ready for level 5':
          'Pengguna secara mandiri, atau dengan sokongan \'tangan ke tangan\', pilih item tersebut dan sentuh kotak suara. Data akan menunjukkan kadar kejayaan peratusan yang tinggi.',
      'level5 name': 'Membina perbendaharaan kata',
      'level 5 folders': 'Kelakuan folder',
      'level 5 folder info':
          'Folder tidak dipaparkan di tahap ini. Ini adalah disengajakan agar pengguna tidak akan menavigasi ke folder lain dan mengalihkan perhatian dari objektif tahap itu',
      'level5 summary':
          'Tahap ini adalah permulaan proses pengajaran dengan matlamat utama adalah untuk membina bahasa untuk Pengguna. \n\nLearning outcome: Pengguna akan mempunyai pemahaman yang jelas tentang 6 atau lebih perkataan dalam satu folder.',
      'level5 Who does this level cater for':
          'This level caters for Users who have accessed Levels 1-4. Users will generally be using the App independently at this stage although some may require ‘hand over hand’ support. \n\nThis level is the start of the teaching process with the primary aim being to build language for the User. The parent/teacher/specialist role becomes more important at this stage as new words should now be introduced to the User, and the parent/teacher/specialist must select words that would be important to the User. The words must also be within the same category ie. using the example of chocolate would require building language for snack items, and the snack items must be those preferred by the User. The categories have been pre-arranged into folders and the words can be made visible as required. If the words/items are not currently available on the folder, the parent/teacher/specialist can take a photo and add them in.\n\nAt this stage, the parent/teacher/specialist must follow the guidance that is provided in the teaching section regarding the use of videos, cards and items. This level takes time and a lot of patience. ‘Hand over hand’ may continue until the User builds his/her confidence.',
      'level5 How do we achieve this':
          'The Parent/Teacher/Specialist section within the App provides detail on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. \n\nThis section includes:\n1.	Continuing to request items\n2.	Matching pictures\n3.	Matching picture to object\n4.	Matching picture to item',
      'level5 How do we get the user to touch the screen':
          'This level requires the User to focus and remain seated to improve communication and build vocabulary. It is unlikely that the User will be willing to engage and therefore it is essential that the main reinforcer is re-introduced. The main reinforcer discussed as an example in the previous summaries was chocolate. In this case the chocolate must be readily available throughout these sessions as the User will be motivated to work if they are provided with a reward. \n\nInitially, the User should be rewarded with their reinforcer after EVERY successful item has been requested ie. when matching every item, the User should be rewarded with a small treat such as a third of a chocolate button. Gradually reduce the reinforcer treat as the User becomes more confident. In time, the User will no longer require a reinforcer. \n\For many this may require ‘hand over hand’ to initially teach the User and show what is expected. All Users will learn this at a different rate. The parent/teacher/specialist should gradually reduce the ‘hand over hand’ depending on the understanding of the User.',
      'How do you know ready for level 6':
          'How do you know the user is ready for level 6?',
      'level5 How do you know ready for level 6':
          'The User will have developed words within this category ie. snacks. This category will continue to be known as the ‘snack’ folder. When a folder contains 6 or more items the User is ready to progress to Level 6. The User would be expected to select items independently although some Users may still prefer ‘hand over hand’ support at this time. Data will continue to be available to show a high percentage success rate in identifying the chosen items. ',
      'level6 name': 'Creating folders',
      'level6 summary':
          'This Level allows Users to develop their language by increasing folders. Folders are created to allow Users to compartmentalize different topics ie. food, transport, clothes. \n\nLearning outcome: The User will show confidence in selecting items. They will be able to move between a minimum of three folders with ease.',
      'level6 Who does this level cater for':
          'This level differs from the others in that it caters for two groups:\n1.	Users who have accessed levels 1-5. These Users will be developing in confidence and most will be using the App independently. Some Users may still require extra support with ‘hand over hand’. Do not discourage this as all Users will develop at a different rate – as confidence grows, the need for support will reduce. \n2.	This would be the suggested stage to introduce the App to Users with limited/zero communication who are visual learners with moderate to good understanding. The parent/teacher/specialist should familiarize themselves with the teaching strategies employed in Levels 1-5 to promote maximum progress and understanding.\n\nThis Level allows Users to develop their language by increasing folders. Folders are created to allow Users to compartmentalize different topics ie. food, transport, clothes. \n\nThe Users who have accessed Levels 1-5 should be engaged and have a clear understanding of what is expected of them. This level allows the parent/teacher/specialist to add different folders to increase the language/speech opportunities. Consider this level as being similar language development for any individual learning a new language. Typical language development starts with one word ie. juice, cat, car. The words come from different folders. We, at Lucas Education, have created a template of folders that we believe are essential for day-to-day communication.',
      'level6 How do we achieve this':
          'One additional folder will be made available to the existing folder in Level 5. For new Users, two folders will be available. The parent/teacher/specialist selects a second folder which contains items that are motivating to the User. When data shows that the User has clearly understood 5 words, the App with allow the opportunity to unlock 5 more words within this folder as well as another folder. \n\nThis process will continue as your User continues to develop and grow. This is a natural process and the same process that all individuals go through when learning to speak and communicate. Level 6 is on-going learning and development.   \n\nThe Parent/Teacher/Specialist section within the App provides further detail on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. Games will be available in due course.\n\nThis section includes:\n1.	Continuing to request items\n2.	Matching pictures\n3.	Matching picture to object\n4.	Matching picture to item',
      'level6 How do we get the user to touch the screen':
          'This Level continues to require the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the program on the move. Examples of such opportunities are when seated in the car or maybe your child enjoys sitting in their pram.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be motivated to work if they are provided with a reward. It is important however to reduce the frequency of the reward. As the language develops, the reinforcer should be reduced and removed.  \n\nThis may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication.',
      'How do you know ready for level 7':
          'How do you know the user is ready for level 7?',
      'level6 How do you know ready for level 7':
          'The User will show confidence in selecting items. They will be able to move between a minimum of three folders with ease. Data will continue to be available to show a high percentage success rate in identifying the chosen items.',
      'level7 name': 'Sentence structure – part one',
      'level7 summary':
          'This Level allows Users to develop sentence structure by introducing a sentence starter. Folders are predesigned to predict possible sentence starters for each folder. \n\nLearning outcome: The User will show confidence in selecting the sentence starter followed by the chosen item. The words will be activated by pressing the voicebox.',
      'level7 Who does this level cater for':
          'This level caters for Users who have accessed Level 6.\n\nThis Level allows Users to develop sentence structure by introducing a sentence starter. Folders are predesigned to predict possible sentence starters for each folder. The option is also available to personalise words.',
      'level7 How do we achieve this':
          'In the previous section, typical language development was discussed. This section takes language development to the next level. Children move from one word level to two. We, at Lucas Education achieve this by introducing sentence starters which vary depending on the folder. Examples of this would be as follows:\n1.	Food folder – I want chocolate……I do not want chocolate.\n2.	Animal folder – I hear cat\n3.	Transport folder – I see car.\n\nSimilar to Level 4, the User may become frustrated during the initial stages of this Level as they are now expected to include a word prior to what has been expected of them in previous levels. For many reinforcers must be introduced again to ensure that the User remains motivated. \n\nAs with the previous folder the words/images will be released when data proves that the User is capable of understanding and consistently includes the sentence starter before requests. Level 7 is on-going learning and development.   \n\nThe Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources.',
      'level7 How do we get the user to touch the screen':
          'This Level also requires the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the programme on the move. Examples of such opportunities are when seated in the car or maybe your child enjoys sitting in their pram.\n\nOnce both icons, namely the sentence starter and the requested item, are appearing in the voice box, the User must touch the voice box and the App will say the sentence for example “I want chocolate” At this point the parent/teacher will give the User what he/she is requesting. The voice box should not be activated until an action and an image are added. Both icons must be spoken in the one voice box; they cannot be selected and spoken independently.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be more motivated to work if they are provided with a reward. This may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication. ',
      'How do you know ready for level 8':
          'How do you know the user is ready for level 8?',
      'level7 How do you know ready for level 8':
          'The User will show confidence in selecting the sentence starter followed by the chosen item. Data will continue to be available to show a high percentage success rate in identifying the chosen items and more sentence starters will be unlocked to develop language further.',
      'level8 name': 'Sentence structure – part two',
      'level8 summary':
          'This level caters for Users who have accessed Level 7.\n\nThis Level allows Users to develop sentence structure by including a sentence closer. Folders are predesigned to predict possible sentence closers for each folder. The option is also available to personalise words.',
      'level8 Who does this level cater for':
          'This level caters for Users who have accessed Level 7.\n\nThis Level allows Users to develop sentence structure by including a sentence closer. Folders are predesigned to predict possible sentence closers for each folder. The option is also available to personalise words.',
      'level8 How do we achieve this':
          'In Level 5, typical language development was promoted and in Level 6 the sentence starters were added. This Level progresses language development to the next level by closing the sentences. We, at Lucas Education achieve this by providing predicted sentence closers which vary depending on the folder. Examples of this would be as follows:\n1.	Food folder – I want chocolate please\n2.	Animal folder – I hear cat\n3.	Transport folder – I see car.\n\nThe final part of the sentences can or cannot be used in conjunction with the action and objects. For example in some cases, the closing part can be used alone eg. All done!\n\nSimilar to Levels 4 and 7, the User may become a little frustrated during the initial stages of this Level as they are now expected to include a word following what has been expected of them in previous levels. For many, reinforcers must be introduced again to ensure that the User remains motivated. \n\nAs with the previous folder the words/images will be released when data proves that the User is capable of understanding and consistently includes the sentence closer after requests. Level 8 is on-going learning and development.\n\The Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. ',
      'level8 How do we get the user to touch the screen':
          'This Level also requires the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the programme on the move. Such opportunities could be made possible at snack time or perhaps when ordering food at a takeaway.\n\nWhen all three icons, namely the sentence starter, the requested item and the sentence closer, are appearing in the voice box, the User must touch the voice box and the App will say the sentence, for example “I want chocolate, please!”. At this point the parent/teacher will give the person what she/he is requesting. The voice box should not be activated until an action, an image and a closer are added. All three icons must be spoken in the one voice box; they cannot be selected and spoken independently.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be more motivated to work if they are provided with a reward. This may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication.',
      'How do you know ready for level 9':
          'How do you know the user is ready for level 9?',
      'level8 How do you know ready for level 9':
          'The User will show confidence in selecting the sentence starter followed by the chosen item and sentence closer. Data will continue to be available to show a high percentage success rate in identifying the chosen items and more sentence closers will be unlocked to develop language further. \n\nUsers at this Level are now capable of accessing Levels 9, 10 and 11. All three Levels are challenging and cater for higher functioning Users. These Levels do not have to taught in a sequential order, for example, the User may find difficulty in progressing through Levels 9 and 10, but may succeed in Level 11.',
      'level9 name': 'Grammar and developed literacy',
      'level9 summary':
          'This Level allows higher functioning Users the opportunity to focus on building sentence structure by developing literacy through use of conjunctions, connectives and pronouns.\nThis is an important building block to teaching the User how to read. \n\nTHIS IS ONE OF THE MORE CHALLENGING LEVELS.\n\nLearning outcome: The User will have the ability to communicate with confidence by linking words with conjunctives and using other literacy cues to develop language further.',
      'level9 Who does this level cater for':
          'This level caters for Users who have accessed Level 8.\n\nThis Level allows higher functioning Users the opportunity to focus on building sentence structure by developing literacy through use of conjunctions, connectives and pronouns.\n\nTHIS IS ONE OF THE MORE CHALLENGING LEVELS.',
      'level9 How do we achieve this':
          'The Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. \n\nData will also assist in gathering success criteria and in unlocking progressive language.',
      'level9 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program. ',
      'How do you know ready for level 10':
          'How do you know the user is ready for level 10?',
      'level9 How do you know ready for level 10':
          'The User is capable to access Level 10 directly from Level 8. All Levels can be used at the same time to develop language. Words will be unlocked when data dictates that the User is ready. ',
      'level10 name': 'Learning words',
      'level10 summary':
          'This Level allows higher functioning Users the opportunity to focus on learning words as opposed to pictures. This Level progresses by removing pictures and replacing them with the name/text of each object. This is the initial step in providing our non-verbal children with the opportunity to read.\n\nLearning outcome: The User will have the ability to communicate with the same confidence by using words as opposed to images.',
      'level10 Who does this level cater for':
          'This level caters for Users who have accessed Level 8 or 9.\n\nThis Level allows higher functioning Users the opportunity to focus on learning words as opposed to pictures. Users who require images should bypass this Level and access Level 10.',
      'level10 How do we achieve this':
          'The Parent/Teacher/Specialist will have an understanding of the favourite words selected by the User. Data will also assist in gathering such details. All words have been set up to show a large image with a small defined word below (show example). The Parent/Teacher/Specialist will now gradually reduce the size of the picture for the favourite words, whilst increasing the size of the word. With time the Parent/Teacher/Specialist will aim to remove the image and only provide the User with the word. Once again, experience and data will provide feedback on the understanding of the User and their readiness to remove images from other buttons.',
      'level10 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program. If they are unable to use the words when the images have been reduced, this is a sign that the User is not ready for this Level and it must be revisited at another stage.',
      'How do you know ready for level 11':
          'How do you know the user is ready for level 11?',
      'level10 How do you know ready for level 11':
          'The User will show confidence in selecting icons with words as opposed to images. Data will continue to be available to show a high percentage success rate in identifying the chosen items.',
      'level11 name': 'predictive images/writing',
      'level11 summary':
          'This Level allows Users the opportunity to communicate with greater speed by providing the User with the opportunity to select predicted images or words. \n\nLearning outcome: The User will have the ability to communicate with the same confidence although at a greater speed and fluency.',
      'level11 Who does this level cater for':
          'This level caters for Users who have accessed Level 8.\n\nThis Level allows Users the opportunity to communicate with greater speed. ',
      'level11 How do we achieve this':
          'This Level provides the User with the opportunity to select predicted images or words. The App will provide a list of actions to be selected by the user. Once an action is selected, the pictures/words to be shown will be presented depending on the frequency of usage for each word. The most used words will appear higher in the grid while less used words for that specific action will appear lower on the grid.',
      'level11 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program',
    },
    // Russian (267 million)
    'ru': {
      'app title': 'LUCAS',
      'relation': 'Связь',
      'schedule day': 'График дня',
      'sound': 'Звук',
      'video': 'видео',
      'story object': 'Сюжетный объект',
      'translation': 'Перевод',
      'start': 'Начать резервное копирование',
      'backup device': 'Сделайте резервную копию этого устройства',
      'Minimum level to show': 'Минимальный уровень для показа',
      'background color': 'Фоновый цвет',
      'loading empty spaces': 'Загрузка пустых мест',
      'loading translations': 'Загрузка переводов',
      'Drag and drop enabled': 'Перетаскивание включено',
      'Drag and drop disabled': 'Перетаскивание отключено',
      'about this app': 'Об этом приложении',
      'text to find': 'найти',
      'text to find instructions':
          'Введите слово или часть слова, чтобы найти в вопросе. Оставьте пустым, чтобы найти все.',
      'number of concepts': 'Количество понятий',
      'one concept': 'Одна концепция',
      'two concepts': 'Две концепции',
      'three or more': 'Три или более концепции',
      'students': 'Студенты',
      'find results': 'Найти результаты',
      'result is correct': 'Результат верный',
      'result is wrong': 'Результат неверный',
      'play quiz': 'Слушайте викторину',
      'silent quiz ongoing': 'Тихая викторина продолжается',
      'send to device': 'Отправить:',
      'quiz type': 'Тип викторины',
      'quiz show image': 'Показать изображения',
      'quiz sound image': 'Произносить понятия',
      'quiz show sound and image':
          'Произнесите концепции и покажите изображения',
      'quiz do not show anything': 'Не показывать ничего',
      'send quiz': 'Отправить тест',
      'schedule_title1': 'желанный',
      'schedule_title2': 'Время суток',
      'schedule_title3': 'Режим редактирования',
      'schedule_title4': 'Добавить объект',
      'schedule_title5': 'Управлять днями',
      'schedule_text1':
          'График позволяет визуализировать вещи, которые будут происходить. Это позволяет вашему пользователю понять, что он будет делать сегодня и в будущем. Вы можете долго нажимать на элемент, чтобы увидеть его больше.',
      'schedule_text2':
          'Скрыть / показать время суток, когда будет происходить каждое действие.',
      'schedule_text3':
          'Режим редактирования позволяет управлять концепциями. В режиме редактирования будут показаны все дни, и вы можете щелкнуть каждый объект, чтобы взаимодействовать с ним.',
      'schedule_text4':
          'Выберите день / время и изображение, которое вы хотите показать.',
      'schedule_text5': 'Если вам нужно добавить новые дни, нажмите здесь.',
      'existing concept':
          'Уже есть концепция для того же дня и часа. Пожалуйста, исправьте и повторите попытку.',
      'please select an object': 'Пожалуйста, выберите объект',
      'please select a day': 'Пожалуйста, выберите день',
      'select an object': 'Выберите объект',
      'add object': 'Добавить объект в расписание',
      'select day': 'Выберите день',
      'selected day': 'Выбранный день',
      'select hour': 'Выберите час',
      'monday': 'понедельник',
      'tuesday': 'вторник',
      'wednesday': 'среда',
      'thursday': 'Четверг',
      'friday': 'пятница',
      'saturday': 'суббота',
      'sunday': 'Воскресенье',
      'school': 'Школа',
      'home': 'Дом',
      'today': 'Cегодня',
      'tomorrow': 'Завтра',
      'no action required title': 'Никаких действий не требуется',
      'no action required info':
          'Пожалуйста, прочитайте предоставленную информацию и продолжите, нажав на значок обучения',
      'reset': 'Сброс',
      'video_title1': 'Вводное видео',
      'video_title2': '1-й уровень',
      'video_title3': 'Уровень 2',
      'video_title4': 'Уровень 3',
      'video_title5': 'Уровень 4',
      'video_title6': 'Уровень 5',
      'video_title7': 'Уровень 6',
      'video_title8': '7 уровень',
      'video_title9': 'Уровень 8',
      'video_title10': 'Уровень 9',
      'video_title11': 'Уровень 10',
      'video_title12': 'Уровень 11',
      'video_title13': 'Пользовательские настройки',
      'video_text1': 'Наше вступительное видео',
      'video_text2': 'Reinforcer видео',
      'video_text3': 'Выбор видео',
      'video_text4': 'Плохой выбор видео',
      'video_text5': 'Видео голосовой ящик',
      'video_text6': 'Создание словарного запаса видео',
      'video_text7': 'Создание папок видео',
      'video_text8': 'Структура предложения - часть первая видео',
      'video_text9': 'Структура предложения - часть вторая видео',
      'video_text10': 'Грамматика и развитая грамотность видео',
      'video_text11': 'Учим слова видео',
      'video_text12': 'Предсказательные изображения / написание видео',
      'video_text13': 'Видео настроек пользователя',
      'showHelper_LevelSettings_title1': 'Первый:',
      'showHelper_LevelSettings_title2': 'Заполните информацию',
      'showHelper_LevelSettings_title3': 'Изменить уровень',
      'showHelper_LevelSettings_title4': 'Экран обучения',
      'showHelper_LevelSettings_text1':
          'Пожалуйста, прочитайте всю информацию, которую мы предоставили для вас',
      'showHelper_LevelSettings_text2':
          'Некоторые уровни требуют информации с вашей стороны. Они четко выделены',
      'showHelper_LevelSettings_text3':
          'Если вам нужно изменить уровни, пожалуйста, сделайте это, нажав на этот значок',
      'showHelper_LevelSettings_text4':
          'Когда все будет готово, вернитесь к экрану обучения',
      'showHelper_image-settings_title1': 'найти',
      'showHelper_image-settings_title2': 'редактировать',
      'showHelper_image-settings_title3': 'Размер сетки',
      'showHelper_image-settings_title4': 'Помогите',
      'showHelper_image-settings_text1':
          'Введите текст и нажмите кнопку, чтобы найти изображения',
      'showHelper_image-settings_text2':
          'Нажмите на изображение, чтобы редактировать его',
      'showHelper_image-settings_text3':
          'Измените размер сетки, нажав эту кнопку',
      'showHelper_image-settings_text4':
          'Включить или отключить помощь с помощью этой кнопки',
      'showHelper_folders_title1': 'щелчок',
      'showHelper_folders_title2': 'Двойной клик',
      'showHelper_folders_title3': 'Долгое нажатие',
      'showHelper_folders_title4': 'Добавить',
      'showHelper_folders_title5': 'Вернуться в родительскую папку',
      'showHelper_folders_text1':
          'Нажмите на предмет, чтобы просмотреть его свойства',
      'showHelper_folders_text2':
          'Дважды щелкните папку, чтобы просмотреть ее дочерние элементы.',
      'showHelper_folders_text3':
          'Длительное нажатие на элемент, чтобы заблокировать / разблокировать его',
      'showHelper_folders_text4': 'Добавить папки, изображения, звуки и видео',
      'showHelper_folders_text5':
          'Чтобы вернуться в родительскую папку, нажмите этот значок',
      'Show Help Screens': 'Показать экраны справки',
      'privacy policy': 'Политика конфиденциальности',
      'must accept privacy policy':
          'Вы должны принять нашу политику конфиденциальности, прежде чем продолжить',
      'view privacy policy': 'Посмотреть политику конфиденциальности',
      'accept privacy policy': 'Принять политику конфиденциальности',
      'show hide schedule': 'Показать / скрыть расписание',
      'show hide stories and schedule':
          'Показать или скрыть истории и расписание',
      'show': 'Показать',
      'hide': 'Спрятать',
      'share item': 'Поделиться',
      'check connection': 'Проверьте подключение',
      'not connected to internet': 'Похоже, вы не подключены к Интернету',
      'user information': 'Информация о пользователе',
      'settings restrictions instructions':
          'Доступ к конфигур��ции может быть ограничен. Это полезно, если пользователь пытается нажать на значок конфигурации, отвлекая себя от процесса обучения. Когда ограничение конфигурации включено, необходимо дать ответ на простую математическую задачу. Если ответ правильный, доступ к разделу конфигурации будет предоставлен. Этот механизм ограничения позволяет родителям и учителям ограничивать доступ к разделу конфигурации без необходимости запоминать и обмениваться паролями.',
      'settings password protected': 'Ограничения настроек',
      'settings password protected no': 'Нет ограничений',
      'settings password protected yes': 'Запрос математического ответа',
      'delete linked device': 'Удалить связанное устройство',
      'confirm delete linked device':
          'Вы хотите удалить связанное устройство? Если вы удалите его, вам нужно будет повторно связать его позже, чтобы добавить снова.',
      'echo device': 'Это устройство будет эхо голосовой ящик',
      'device silent': 'Это устройство будет молчать',
      'device blocked': 'Устройство теперь заблокировано.',
      'device unblocked': 'Устройство было разблокировано.',
      'output voicebox to device':
          'Вывести голосовой ящик на другое устройство',
      'quizzes': 'Викторины',
      'quizzes instructions':
          'Тесты могут быть созданы (как учитель / педагог) на этом устройстве (тесты могут быть получены ответы на любом устройстве)',
      'can create quiz': 'Можно создать викторину',
      'can not create quiz': 'Не могу создать викторину',
      'invite rejected': 'Приглашение отклонено',
      'invite sent': 'Приглашение отправлено на',
      'recieved invite': 'Вы получили приглашение для связи с',
      'accept': 'принимать',
      'ignore and dismiss': 'Игнорировать и отклонять',
      'invite confirmed': 'Приглашение подтверждено',
      'invite accepted': 'Приглашение принято',
      'remember link other party':
          'Помните: повторите тот же процесс на другом устройстве.',
      'please enter remote email':
          'Пожалуйста, введите адрес электронной почты другой стороны',
      'add new device': 'Добавить новое устройство',
      'remote user email': 'Удаленная электронная почта пользователя',
      'remote user email instructions':
          'Чтобы создать связь между двумя устройствами, убедитесь, что оба устройства включены, подключены к Интернету, запущено приложение и отображается экран связанных устройств (этот экран). Установление ссылки должно быть выполнено на обоих устройствах (каждое устройство должно ввести адрес электронной почты другого участника)',
      'enter remote user email':
          'Введите адрес электронной почты удаленного пользователя',
      'warning': 'Предупреждение',
      'email or name not filled':
          'E-mail или имя не заполнено. Пожалуйста, заполните эту информацию, прежде чем пытаться связать новые устройства.',
      'email or name required for backup':
          'Электронная почта или имя не заполнены. Пожалуйста, заполните эту информацию, прежде чем пытаться сделать резервную копию устройства.',
      'email or name required for restore':
          'Электронная почта требуется для восстановления',
      'start restore': 'Начать восстановление',
      'replace folder': 'Заменить папку',
      'add to folder': 'Добавить в папку',
      'what to do with folder':
          'Выберите локальную папку, которую нужно заменить. Рекомендуется создать резервную копию этого устройства перед восстановлением любой папки, так как содержимое локальной папки будет удалено перед заменой его удаленной папкой.',
      'choose folder to restore': 'Выберите папку для восстановления',
      'quiz': 'экзамен',
      'linked devices': 'Связанные устройства',
      'no linked devices': 'Нет связанных устройств, где найдено',
      'change user name': 'Изменение имени пользователя',
      'confirm change user name': 'Вы хотите изменить имя пользователя?',
      'user name': 'Имя пользователя',
      'user name hint': 'Введите имя пользователя',
      'change user email': 'Изменить e-mail',
      'confirm change user email':
          'Если вы измените адрес электронной почты пользователя, вам нужно будет повторно связать устройства (родитель или преподаватель должны будут воссоздать ссылку на это устройство). Вы хотите продолжить?',
      'user email': 'Электронная почта пользователя',
      'user email instructions':
          'Введите адрес электронной почты, который будет использоваться пользователем. Это может быть адрес электронной почты родителя, если у пользователя его нет. Не помещайте электронную почту преподавателя или учителя в это поле. Электронная почта используется для идентификации как уникального каждого пользователя. Электронная почта используется для связи устройств для синхронизации или опроса.',
      'user email hint': 'Введите адрес электронной почты',
      'toggle visibility for all': 'Изменить видимость всех концепций',
      'item availability': 'Наличие товара',
      'item availability instructions':
          'Если предмет недоступен, вы можете указать его. Недоступные предметы будут показаны с красным крестиком над изображением',
      'is available': 'Доступен',
      'is not available': 'Не доступен',
      'not available': 'Нет в наличии',
      'available': 'Доступный',
      'delete story': 'Удалить историю',
      'confirm delete story': 'Вы уверены, что хотите удалить историю?',
      'level not enabled': 'Уровень не включен',
      'not enough data':
          'Интеллектуальная запись не включена, потому что недостаточно данных было собрано',
      'image size': 'Размер изображения',
      'text size': 'Размер текста',
      'small': 'Небольшой',
      'medium': 'средний',
      'large': 'большой',
      'select video': 'Выберите видео',
      'selected video': 'Выбранное видео:',
      'recording': 'Запись ...',
      'story object instructions':
          'Вы можете отклонить понятия, проводя их. Ничто не будет удалено. (концепции удаляются только в режиме редактирования)',
      'edit story name': 'Изменить название истории',
      'select this concept': 'Выберите эту концепцию',
      'no story object instructions': '',
      'add story object': 'Добавить концепцию',
      'story name hint': 'Введите название истории',
      'create new story': 'Создать новую историю',
      'no stories instructions':
          'Истории позволяют объединять понятия (изображения, звуки и видео) для объяснения новых идей. Например, вы можете объяснить посещение зоопарка, которое начинается с принятия душа, одевания, завтрака, поездки на машине и наблюдения за животными.',
      'add story': 'Добавить историю',
      'please confirm': 'Пожалуйста подтвердите',
      'replace sound confirmation': 'Хотите заменить существующий звук?',
      'replace': 'замещать',
      'voiceBoxSize': 'Размер голосового ящика',
      'big': 'большой',
      'select sound': 'Запись аудио',
      'select sound instructions':
          'Запишите звук, который вы хотите. Этот звук может быть воспроизведен, когда пользователь нажимает на изображение.',
      'delete': 'удалять',
      'delete confirmation':
          'Пожалуйста, подтвердите, что вы хотите удалить этот объект. Эта операция необратима.',
      'warning not user created':
          'ВНИМАНИЕ: этот объект по умолчанию включен в приложение. Если вы удалите его, восстановить его будет невозможно, и вам придется вручную добавить его с изображением и текстом на каждом языке.',
      'folder not empty will not delete':
          'Папка должна быть пустой перед удалением',
      'local device': 'устройство',
      'library': 'Библиотека',
      'camara': 'камера',
      'folder should talk': 'Скажите имя папки',
      'folder should talk instructions':
          'Включите, если вы хотите услышать название папки при нажатии на нее.',
      'loading images': 'Загрузка изображений',
      'loading folders': 'Загрузка папок',
      'loading relations': 'Загрузка отношений',
      'loading categories': 'Загрузка категорий',
      'loading videos': 'Загрузка видео',
      'loading sounds': 'Загрузка звуков',
      'allowLongPressInLearningScreen':
          'Разрешить долгое нажатие концепции в режиме обучения',
      'long press instructions':
          'В режиме обучения, если пользователь будет долго нажимать на концепцию, будет показан экран с подробной информацией о выбранной опции.',
      'Not assigned': 'Не назначен',
      'nothing unlocked': 'Ничего не разблокировано',
      'nothing unlocked instructions':
          'Перед использованием этой сетки, вы должны выбрать (показать / разблокировать) концепции, которые вы хотите. Блокируйте / разблокируйте концепции, удерживая их нажатыми. Помните, что папки не отображаются на этом уровне.',
      'please unlock':
          'Пожалуйста, разблокируйте / сделайте видимыми элементы, которые вы хотите в конфигурации, папках',
      'default folder': 'Папка по умолчанию',
      'open folders': 'Открытые папки',
      'default folder instructions':
          'Чтобы выбрать эту папку в качестве папки по умолчанию, нажмите кнопку',
      'understood': 'Понимал',
      'not understood': 'Не понял',
      'is understood': 'Понятие понято',
      'is not understood': 'Концепция еще не понята',
      'conceptIsUnderstood': 'Понимание концепции',
      'conceptIsUnderstoodInstructions':
          'Как только у пользователя появится четкое понятие, пометьте его как понятное. Это помогает учителям и родителям общаться. Все понятые концепции выделены зеленым цветом в сетке обучения.',
      'object visible': 'Объект в настоящее время виден',
      'object not visible': 'Объект в данный момент не виден',
      'visibility': 'видимость',
      'visibility instructions':
          'Показать или скрыть (разблокировать / заблокировать) изображения, которые вы хотите',
      'image to show': 'Изображение для показа',
      'text to show': 'Текст для показа',
      'text to show instructions':
          'Это текст, показанный под каждым изображением в сетке обучения.',
      'text to show hint': 'Введите текст для отображения',
      'text to say': 'Текст, чтобы сказать',
      'text to say instructions':
          'Вы можете изменить то, что сказать! Вместо того чтобы сказать «Меня зовут ...», вы можете изменить его на «Меня зовут [введите имя здесь]» или «Моя сестра - [имя сестры]». Также полезно иметь короткий текст для отображения, но длинный текст, чтобы сказать, например, когда изображение представляет собой длинную фразу.',
      'text to say hint': 'Введите текст, чтобы сказать',
      'edit': 'редактировать',
      'no default folder': 'Папка по умолчанию не выбрана',
      'please select a default folder':
          'Выберите папку по умолчанию. Будут показаны только изображения, которые вы разблокировали из этой папки.',
      'select folder': 'Выберите папку по умолчанию',
      'select a folder':
          'Выберите удаленную папку, которую вы хотите импортировать',
      'current default folder': 'Текущая папка по умолчанию:',
      'unlock': 'разблокировка',
      'lock': 'Замок',
      'debug mode': 'Режим отладки',
      'user profile': 'Пользовательские настройки',
      'add': 'Добавлять',
      'Grid size': 'Размер сетки',
      'grid size instructions':
          'При желании вы можете изменить размер сетки (столбцы и строки). Измените этот параметр, только если у вас есть устройство с большим экраном. Убедитесь, что пользователь может удобно видеть и нажимать на каждый значок.',
      'operation completed successfully': 'Операция успешно завершена',
      'restore device': 'Восстановить устройство',
      'user email to restore':
          'Электронная почта пользователя для восстановления',
      'categories': 'категории',
      'category': 'категория',
      'close': 'близко',
      'add folder': 'Добавить папку',
      'add image': 'Добавить изображение',
      'add empty': 'Добавить пустое место',
      'add video': 'Добавить видео',
      'add sound': 'Добавить звук',
      'new folder name': '',
      'new image name': '',
      'new video name': '',
      'new sound name': '',
      'show folder': 'Показать папку',
      'hide folder': 'Скрыть папку',
      'delete folder': 'Удалить папку',
      'folder instructions':
          'Нажмите или дважды щелкните изображение или пустое место, чтобы активировать его параметры. Нажмите на меню, чтобы изучить дополнительные параметры.',
      'grid instructions':
          'В зависимости от потребностей пользователя (для значков большего размера) или размера экрана устройства, вы можете изменить размер сетки отображаемых изображений, начиная с уровня 5.',
      'grid': 'сетка',
      'Columns': 'Колонны',
      'Rows': 'Ряды',
      'folders': 'Папки',
      'level not found': 'Уровень не найден',
      'missing reinforcer': 'Отсутствует подкрепление',
      'confirm reinforcer':
          'Пожалуйста, подтвердите, что вы хотите использовать ',
      'selected reinforcer': 'Ваш текущий выбранный усилитель:',
      'please select a reinforcer':
          'Пожалуйста, выберите усилитель для этого уровня',
      'cancel': 'Отмена',
      'learn': 'Учиться',
      'stories': 'Рассказы',
      'schedule': 'График',
      'help videos': 'Помощь видео',
      'images': 'Картинки',
      'colors': 'Цвета',
      'amber': 'янтарный',
      'blue': 'синий',
      'cyan': 'Cyan',
      'deepOrange': 'Темно-оранжевый',
      'deepPurple': 'Темно-фиолетовый',
      'green': 'зеленый',
      'indigo': 'Индиго',
      'lightBlue': 'Светло-синий',
      'lightGreen': 'Светло-зеленый',
      'lime': 'Лайм',
      'orange': 'оранжевый',
      'pink': 'розовый',
      'purple': 'Фиолетовый',
      'red': 'красный',
      'teal': 'чирок',
      'yellow': 'желтый',
      'dark mode': 'Темный режим',
      'select this theme': 'Выберите эту тему',
      'select voice': 'Выберите голос',
      'no voice selected':
          'Голос не выбран. Если вы не выберете голос, приложение не сможет произнести ни слова.',
      'tts': 'Текст в речь',
      'voice speed': 'Скорость голоса',
      'say': 'Скажи вслух',
      'send by email': 'Послать по электронной почте',
      'user name not configured': 'Имя пользователя не настроено',
      'change': '+ Изменить',
      'no valid voice found': 'Действительный голос не найден',
      'test voice': 'Тестовый голос. Нажмите, чтобы активировать.',
      'test text':
          'Если вы можете услышать это предложение, значит, вы правильно настроили голос.',
      'settings title': 'конфигурация',
      'levels': 'Уровни',
      'language': 'язык',
      'select language instructions': 'Выберите предпочитаемый язык',
      'Chinese': 'китайский язык',
      'English': 'английский',
      'Hindi': 'хинди',
      'Spanish': 'испанский',
      'Arabic': 'арабский',
      'Malay': 'малайский',
      'Russian': 'русский',
      'Bengali': 'бенгальский',
      'Portuguese': 'португальский',
      'French': 'французкий язык',
      'German': 'Немецкий',
      'find image': 'Найти изображение',
      'selected level': 'Выбранный уровень',
      'level1': 'Уровень 1',
      'level2': 'Уровень 2',
      'level3': 'Уровень 3',
      'level4': 'Уровень 4',
      'level5': 'Уровень 5',
      'level6': 'Уровень 6',
      'level7': 'Уровень 7',
      'level8': 'Уровень 8',
      'level9': 'Уровень 9',
      'level10': 'Уровень 10',
      'level11': 'Уровень 11',
      'change level': 'Изменить уровень',
      'summary': 'Резюме',
      'level1 name': 'упрочнитель',
      'level1 summary':
          'Основная функция этого уровня состоит в том, чтобы мотивировать пользователя касаться экрана. Результат обучения достигается, когда пользователь самостоятельно касается экрана, чтобы запросить один объект.',
      'Who does this level cater for': 'Для кого предназначен этот уровень?',
      'level1 Who does this level cater for':
          'Ребенок или взрослый с ограниченным, нулевым общением. Основная функция этого уровня состоит в том, чтобы побудить пользователя мотивировать приложение / устройство',
      'How do we achieve this?': 'Как нам этого добиться?',
      'level1 How do we achieve this':
          'Родитель / учитель / специалист должен знать о подкреплении ребенка. Усилитель - это предмет или предмет, которым пользуется пользователь или которым он пользуется. Хорошим примером этого будет продукт питания, такой как шоколад.',
      'select reinforcer': 'Выберите усилитель',
      'How do we get the user to touch the screen?':
          'Как заставить пользователя прикоснуться к экрану?',
      'level1 How do we get the user to touch the screen':
          'Уровень 1 настроен как один экран / кнопка, которая говорит, как только к ней прикоснуться. Используя пример шоколада, родитель / учитель / специалист должен настроить приложение, чтобы показать изображение шоколада. Родитель / учитель / специалист ДОЛЖНЫ быть подготовлены во время каждой учебной сессии, имея много маленьких кусочков шоколада, которые могут обеспечить мгновенное вознаграждение пользователю. Помните, важно выделить время для учебных занятий, но каждый момент дня может быть возможностью для обучения. Имейте iPad в месте, где у Пользователя есть все возможности его использовать. \n\nВо время учебного занятия \n1. Предложите небольшой кусочек шоколада пользователю. Лучше всего посадить пользователя, хотя это не всегда возможно. \n2. Используйте «hand over hand», чтобы побудить пользователя коснуться экрана. «Передай руку» - это метод обучения, используемый с аутичными детьми. Родитель / учитель / специалист помогает пользователю, побуждая его / ее нажать кнопку. Родитель / учитель / специалист кладет руку на руку пользователя и направляет их к выбранной кнопке. * \n3. Как только приложение говорит, родитель / учитель / специалист должен немедленно передать шоколад пользователю. \n4. Это должно повторяться регулярно в течение периода до 5 минут, если пользователь не разочарован. Не давайте пользователю шоколад, пока кнопка не будет нажата, независимо от того, насколько он разочарован. \n5. Если пользователь разочарован, не сдавайтесь. Это длительный процесс, но долгосрочная выгода настроит пользователя на всю жизнь. Остановите и повторите эту задачу, когда пользователь успокоится. \n\nПовторите шаги 1-5 через регулярные промежутки времени в течение дня. Многие пользователи очень быстро добьются успеха на этом уровне, а другим потребуется много тяжелой работы, терпения и усилий. \n\n * Сила этой помощи должна постепенно уменьшаться. Это может занять несколько месяцев, чтобы удалить полностью.',
      'How do you know ready for level 2':
          'Как вы знаете, пользователь готов к уровню 3?',
      'level1 How do you know ready for level 2':
          'Пользователь снизит потребность в «сдаче руки», когда вы заметите, что ваш ребенок начинает понимать, что это приложение помогает им получить свое подкрепление. Когда пользователь нажимает кнопку независимо и последовательно, без какой-либо поддержки со стороны родителя / учителя, пользователь готов к уровню 2',
      'level2 name': 'Выбор',
      'level2 summary':
          'Этот уровень предназначен для того, чтобы научить пользователя, что есть более чем один вариант для полезного результата. \n\nРезультат обучения: пользователь будет иметь возможность запрашивать оба элемента последовательно и с пониманием.',
      'level2 Who does this level cater for':
          'Этот уровень обслуживает пользователей, которые получили доступ к уровню 1 и минимально нуждаются в «передаче рук». Пользователь прогрессирует, предлагая два варианта, которые побуждают его сделать выбор.',
      'level2 How do we achieve this':
          'Родитель / учитель / специалист должен убедиться, что второе изображение, добавляемое на экран, является вторым усилителем, например соком. \n\nПользователь теперь будет иметь возможность запросить два своих любимых элемента, и это создаст их отношения с приложением.',
      'select second reinforcer': 'Выберите второй усилитель',
      'level2 How do we get the user to touch the screen':
          'Родитель / учитель / специалист будут использовать те же стратегии, что и на уровне 1. Таким образом, эти два элемента должны быть легко доступны и предоставлены пользователю по запросу. \n\nВажно убедиться, что пользователь получает правильный товар и знает о различии в двух изображениях. Пользователю должен быть показан один из пунктов, и он должен запрашивать это точно и последовательно. Данные будут доступны, чтобы выделить ответы и показать точность. \n\nЭтот уровень является одним из самых быстрых уровней для прохождения, так как пользователь уже должен быть мотивирован подкреплением уровня 1.',
      'How do you know ready for level 3':
          'How do you know the user is ready for level 3?',
      'level2 How do you know ready for level 3':
          'Пользователь продемонстрирует повышенную уверенность в самостоятельном использовании Приложения, и необходимость в «передаче в руки» должна быть ограничена. \n\nЕсли пользователь нажимает кнопки независимо и последовательно, при ограниченной поддержке со стороны родителя / учителя / специалиста, это признак того, что пользователь готов к уровню 3.',
      'level3 name': 'Плохие выборы',
      'level3 summary':
          'На этом этапе пользователь будет понимать, что приложение обеспечивает результат, который доставляет ему удовольствие. Важно, чтобы этот уровень был обеспечен, так как этот прогресс учит пользователя, что все варианты не приносят пользы, а являются общением. Этот уровень достигается в короткие сроки. \n\nРезультат обучения: пользователь должен проявлять отвращение к получению не предпочтительного варианта. Пользователь больше не будет выбирать эту опцию.',
      'level3 Who does this level cater for':
          'Этот уровень обслуживает пользователей, которые имеют доступ к уровням 1 и 2 и имеют минимальную / нулевую потребность в «передаче рук». Пользователь прогрессирует, предлагая третий вариант, который не является благоприятным выбором.',
      'level3 How do we achieve this':
          'На этом этапе развития у пользователя теперь будет не предпочтительный вариант. Родитель / учитель / специалист должен убедиться, что третье изображение, добавляемое на экран, не является предпочтительным элементом, например, носком. \n\nПользователь теперь будет иметь возможность запросить два предпочтительных варианта и один не предпочтительный вариант.',
      'select third reinforcer': 'Выберите третье слово',
      'level3 How do we get the user to touch the screen':
          'Теперь пользователь должен быть мотивирован приложением и будет заинтригован прикосновением к изображениям. Они получили удовольствие от изображений на сегодняшний день. Пользователь будет любознательным и должен пожелать получить положительный результат от не предпочтительного пункта. Она / он должны быть мотивированы без стимула со стороны родителя / учителя / специалиста, однако, если это не так, тогда родитель / учитель / специалист должен следовать стратегиям уровня 1, чтобы стимулировать это взаимодействие. \n\nЕсли пользователь выбирает / касается Любое из трех изображений, они получат предмет мгновенно. Первые три уровня предназначены для обучения пользователя тому, как запросить товар. Этот уровень объединяет тот факт, что не все варианты приятны, это запросы. Теперь пользователь будет учиться считать, что изображения, к которым он прикасается, будут элементами, которые он получает, независимо от того, нравятся они им или нет.',
      'How do you know ready for level 4':
          'Откуда вы знаете, что пользователь готов к 4 уровню?',
      'level3 How do you know ready for level 4':
          'Пользователь покажет разочарование при получении непривилегированного товара и будет по-прежнему доволен другими запрошенными товарами. Родитель / учитель / специалист должен по-прежнему наблюдать улучшение уверенности в использовании приложения самостоятельно. \n\nКогда пользователь нажимает кнопки независимо и последовательно, без какой-либо поддержки со стороны родителя / учителя / специалиста, пользователь готов к уровню 4. Данные подтвердят эти наблюдения. Кроме того, пользователь должен проявлять отвращение к получению не предпочтительного варианта. Пользователь больше не будет выбирать эту опцию.',
      'level4 name': 'Голос окно',
      'level4 summary':
          'Этот уровень предназначен для начала построения языковой структуры, которая будет использоваться на следующих уровнях. Награда за пользователя будет предоставлена только после того, как он выберет изображение и коснется голосового окна. \n\nРезультат обучения: пользователь выберет выбранный предмет и поймет, что предмет не будет предоставлен, пока он / он касается голосовой коробки.',
      'level4 Who does this level cater for':
          'Этот уровень обслуживает пользователей, которые имеют доступ к уровням 1-3 и теперь используют приложение независимо друг от друга с минимальной / нулевой поддержкой «hand hand». \n\nЭтот уровень является одним из наиболее сложных уровней для родителя / учителя / специалиста и разочаровывающих уровней для пользователя. Цель этого уровня - научить пользователя использовать голосовой ящик, который позволяет развивать язык. На этом этапе родитель / учитель / специалист планирует развивать язык, подготавливая пользователя к использованию уровня из двух слов, т.е. хочу шоколад. Этот уровень требует времени и терпения. Это может потребовать возврата обратно к «передаче руки» на короткое время.',
      'level4 How do we achieve this':
          'На этом этапе экран уровня 3 остается с теми же тремя опциями, хотя на экране теперь есть длинная полоса в верхней части экрана. Эта полоса называется «голосовой ящик». Когда пользователь касается обычных изображений, слово больше не будет произнесено немедленно. Теперь он будет отображаться в голосовом поле в верхней части экрана. Теперь пользователь должен коснуться голосового поля, чтобы разрешить произносить выбранные слова.',
      'level4 How do we get the user to touch the screen':
          'Пользователь больше не будет получать мгновенное вознаграждение при запросе товара. Она / она должны быть поощрены прикоснуться к голосовой коробке. Для этого потребуется «сдать в руки», чтобы сначала обучить пользователя и показать, что ожидается. Все пользователи будут изучать это с различной скоростью. Родитель / учитель / специалист должен постепенно сокращать «передачу» в зависимости от понимания Пользователя.',
      'How do you know ready for level 5':
          'Откуда вы знаете, что пользователь готов к 5 уровню?',
      'level4 How do you know ready for level 5':
          'Пользователь самостоятельно или с поддержкой «hand over hand» выберет элемент и коснется голосового окна. Данные покажут высокий процент успеха.',
      'level5 name': 'Пополнение словарного запаса',
      'level 5 folders': 'Поведение папок',
      'level 5 folder info':
          'Папки не отображаются на этом уровне. Это сделано намеренно, поэтому пользователь не будет переходить в другие папки и отвлекаться от цели уровня',
      'level5 summary':
          'Этот уровень является началом учебного процесса, основной целью которого является создание языка для пользователя. \n\nУчение обучения: пользователь будет четко понимать 6 или более слов в одной папке.',
      'level5 Who does this level cater for':
          'This level caters for Users who have accessed Levels 1-4. Users will generally be using the App independently at this stage although some may require ‘hand over hand’ support. \n\nThis level is the start of the teaching process with the primary aim being to build language for the User. The parent/teacher/specialist role becomes more important at this stage as new words should now be introduced to the User, and the parent/teacher/specialist must select words that would be important to the User. The words must also be within the same category ie. using the example of chocolate would require building language for snack items, and the snack items must be those preferred by the User. The categories have been pre-arranged into folders and the words can be made visible as required. If the words/items are not currently available on the folder, the parent/teacher/specialist can take a photo and add them in.\n\nAt this stage, the parent/teacher/specialist must follow the guidance that is provided in the teaching section regarding the use of videos, cards and items. This level takes time and a lot of patience. ‘Hand over hand’ may continue until the User builds his/her confidence.',
      'level5 How do we achieve this':
          'The Parent/Teacher/Specialist section within the App provides detail on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. \n\nThis section includes:\n1.	Continuing to request items\n2.	Matching pictures\n3.	Matching picture to object\n4.	Matching picture to item',
      'level5 How do we get the user to touch the screen':
          'This level requires the User to focus and remain seated to improve communication and build vocabulary. It is unlikely that the User will be willing to engage and therefore it is essential that the main reinforcer is re-introduced. The main reinforcer discussed as an example in the previous summaries was chocolate. In this case the chocolate must be readily available throughout these sessions as the User will be motivated to work if they are provided with a reward. \n\nInitially, the User should be rewarded with their reinforcer after EVERY successful item has been requested ie. when matching every item, the User should be rewarded with a small treat such as a third of a chocolate button. Gradually reduce the reinforcer treat as the User becomes more confident. In time, the User will no longer require a reinforcer. \n\For many this may require ‘hand over hand’ to initially teach the User and show what is expected. All Users will learn this at a different rate. The parent/teacher/specialist should gradually reduce the ‘hand over hand’ depending on the understanding of the User.',
      'How do you know ready for level 6':
          'How do you know the user is ready for level 6?',
      'level5 How do you know ready for level 6':
          'The User will have developed words within this category ie. snacks. This category will continue to be known as the ‘snack’ folder. When a folder contains 6 or more items the User is ready to progress to Level 6. The User would be expected to select items independently although some Users may still prefer ‘hand over hand’ support at this time. Data will continue to be available to show a high percentage success rate in identifying the chosen items. ',
      'level6 name': 'Creating folders',
      'level6 summary':
          'This Level allows Users to develop their language by increasing folders. Folders are created to allow Users to compartmentalize different topics ie. food, transport, clothes. \n\nLearning outcome: The User will show confidence in selecting items. They will be able to move between a minimum of three folders with ease.',
      'level6 Who does this level cater for':
          'This level differs from the others in that it caters for two groups:\n1.	Users who have accessed levels 1-5. These Users will be developing in confidence and most will be using the App independently. Some Users may still require extra support with ‘hand over hand’. Do not discourage this as all Users will develop at a different rate – as confidence grows, the need for support will reduce. \n2.	This would be the suggested stage to introduce the App to Users with limited/zero communication who are visual learners with moderate to good understanding. The parent/teacher/specialist should familiarize themselves with the teaching strategies employed in Levels 1-5 to promote maximum progress and understanding.\n\nThis Level allows Users to develop their language by increasing folders. Folders are created to allow Users to compartmentalize different topics ie. food, transport, clothes. \n\nThe Users who have accessed Levels 1-5 should be engaged and have a clear understanding of what is expected of them. This level allows the parent/teacher/specialist to add different folders to increase the language/speech opportunities. Consider this level as being similar language development for any individual learning a new language. Typical language development starts with one word ie. juice, cat, car. The words come from different folders. We, at Lucas Education, have created a template of folders that we believe are essential for day-to-day communication.',
      'level6 How do we achieve this':
          'One additional folder will be made available to the existing folder in Level 5. For new Users, two folders will be available. The parent/teacher/specialist selects a second folder which contains items that are motivating to the User. When data shows that the User has clearly understood 5 words, the App with allow the opportunity to unlock 5 more words within this folder as well as another folder. \n\nThis process will continue as your User continues to develop and grow. This is a natural process and the same process that all individuals go through when learning to speak and communicate. Level 6 is on-going learning and development.   \n\nThe Parent/Teacher/Specialist section within the App provides further detail on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. Games will be available in due course.\n\nThis section includes:\n1.	Continuing to request items\n2.	Matching pictures\n3.	Matching picture to object\n4.	Matching picture to item',
      'level6 How do we get the user to touch the screen':
          'This Level continues to require the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the program on the move. Examples of such opportunities are when seated in the car or maybe your child enjoys sitting in their pram.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be motivated to work if they are provided with a reward. It is important however to reduce the frequency of the reward. As the language develops, the reinforcer should be reduced and removed.  \n\nThis may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication.',
      'How do you know ready for level 7':
          'How do you know the user is ready for level 7?',
      'level6 How do you know ready for level 7':
          'The User will show confidence in selecting items. They will be able to move between a minimum of three folders with ease. Data will continue to be available to show a high percentage success rate in identifying the chosen items.',
      'level7 name': 'Sentence structure – part one',
      'level7 summary':
          'This Level allows Users to develop sentence structure by introducing a sentence starter. Folders are predesigned to predict possible sentence starters for each folder. \n\nLearning outcome: The User will show confidence in selecting the sentence starter followed by the chosen item. The words will be activated by pressing the voicebox.',
      'level7 Who does this level cater for':
          'This level caters for Users who have accessed Level 6.\n\nThis Level allows Users to develop sentence structure by introducing a sentence starter. Folders are predesigned to predict possible sentence starters for each folder. The option is also available to personalise words.',
      'level7 How do we achieve this':
          'In the previous section, typical language development was discussed. This section takes language development to the next level. Children move from one word level to two. We, at Lucas Education achieve this by introducing sentence starters which vary depending on the folder. Examples of this would be as follows:\n1.	Food folder – I want chocolate……I do not want chocolate.\n2.	Animal folder – I hear cat\n3.	Transport folder – I see car.\n\nSimilar to Level 4, the User may become frustrated during the initial stages of this Level as they are now expected to include a word prior to what has been expected of them in previous levels. For many reinforcers must be introduced again to ensure that the User remains motivated. \n\nAs with the previous folder the words/images will be released when data proves that the User is capable of understanding and consistently includes the sentence starter before requests. Level 7 is on-going learning and development.   \n\nThe Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources.',
      'level7 How do we get the user to touch the screen':
          'This Level also requires the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the programme on the move. Examples of such opportunities are when seated in the car or maybe your child enjoys sitting in their pram.\n\nOnce both icons, namely the sentence starter and the requested item, are appearing in the voice box, the User must touch the voice box and the App will say the sentence for example “I want chocolate” At this point the parent/teacher will give the User what he/she is requesting. The voice box should not be activated until an action and an image are added. Both icons must be spoken in the one voice box; they cannot be selected and spoken independently.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be more motivated to work if they are provided with a reward. This may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication. ',
      'How do you know ready for level 8':
          'How do you know the user is ready for level 8?',
      'level7 How do you know ready for level 8':
          'The User will show confidence in selecting the sentence starter followed by the chosen item. Data will continue to be available to show a high percentage success rate in identifying the chosen items and more sentence starters will be unlocked to develop language further.',
      'level8 name': 'Sentence structure – part two',
      'level8 summary':
          'This level caters for Users who have accessed Level 7.\n\nThis Level allows Users to develop sentence structure by including a sentence closer. Folders are predesigned to predict possible sentence closers for each folder. The option is also available to personalise words.',
      'level8 Who does this level cater for':
          'This level caters for Users who have accessed Level 7.\n\nThis Level allows Users to develop sentence structure by including a sentence closer. Folders are predesigned to predict possible sentence closers for each folder. The option is also available to personalise words.',
      'level8 How do we achieve this':
          'In Level 5, typical language development was promoted and in Level 6 the sentence starters were added. This Level progresses language development to the next level by closing the sentences. We, at Lucas Education achieve this by providing predicted sentence closers which vary depending on the folder. Examples of this would be as follows:\n1.	Food folder – I want chocolate please\n2.	Animal folder – I hear cat\n3.	Transport folder – I see car.\n\nThe final part of the sentences can or cannot be used in conjunction with the action and objects. For example in some cases, the closing part can be used alone eg. All done!\n\nSimilar to Levels 4 and 7, the User may become a little frustrated during the initial stages of this Level as they are now expected to include a word following what has been expected of them in previous levels. For many, reinforcers must be introduced again to ensure that the User remains motivated. \n\nAs with the previous folder the words/images will be released when data proves that the User is capable of understanding and consistently includes the sentence closer after requests. Level 8 is on-going learning and development.\n\The Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. ',
      'level8 How do we get the user to touch the screen':
          'This Level also requires the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the programme on the move. Such opportunities could be made possible at snack time or perhaps when ordering food at a takeaway.\n\nWhen all three icons, namely the sentence starter, the requested item and the sentence closer, are appearing in the voice box, the User must touch the voice box and the App will say the sentence, for example “I want chocolate, please!”. At this point the parent/teacher will give the person what she/he is requesting. The voice box should not be activated until an action, an image and a closer are added. All three icons must be spoken in the one voice box; they cannot be selected and spoken independently.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be more motivated to work if they are provided with a reward. This may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication.',
      'How do you know ready for level 9':
          'How do you know the user is ready for level 9?',
      'level8 How do you know ready for level 9':
          'The User will show confidence in selecting the sentence starter followed by the chosen item and sentence closer. Data will continue to be available to show a high percentage success rate in identifying the chosen items and more sentence closers will be unlocked to develop language further. \n\nUsers at this Level are now capable of accessing Levels 9, 10 and 11. All three Levels are challenging and cater for higher functioning Users. These Levels do not have to taught in a sequential order, for example, the User may find difficulty in progressing through Levels 9 and 10, but may succeed in Level 11.',
      'level9 name': 'Grammar and developed literacy',
      'level9 summary':
          'This Level allows higher functioning Users the opportunity to focus on building sentence structure by developing literacy through use of conjunctions, connectives and pronouns.\nThis is an important building block to teaching the User how to read. \n\nTHIS IS ONE OF THE MORE CHALLENGING LEVELS.\n\nLearning outcome: The User will have the ability to communicate with confidence by linking words with conjunctives and using other literacy cues to develop language further.',
      'level9 Who does this level cater for':
          'This level caters for Users who have accessed Level 8.\n\nThis Level allows higher functioning Users the opportunity to focus on building sentence structure by developing literacy through use of conjunctions, connectives and pronouns.\n\nTHIS IS ONE OF THE MORE CHALLENGING LEVELS.',
      'level9 How do we achieve this':
          'The Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. \n\nData will also assist in gathering success criteria and in unlocking progressive language.',
      'level9 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program. ',
      'How do you know ready for level 10':
          'How do you know the user is ready for level 10?',
      'level9 How do you know ready for level 10':
          'The User is capable to access Level 10 directly from Level 8. All Levels can be used at the same time to develop language. Words will be unlocked when data dictates that the User is ready. ',
      'level10 name': 'Learning words',
      'level10 summary':
          'This Level allows higher functioning Users the opportunity to focus on learning words as opposed to pictures. This Level progresses by removing pictures and replacing them with the name/text of each object. This is the initial step in providing our non-verbal children with the opportunity to read.\n\nLearning outcome: The User will have the ability to communicate with the same confidence by using words as opposed to images.',
      'level10 Who does this level cater for':
          'This level caters for Users who have accessed Level 8 or 9.\n\nThis Level allows higher functioning Users the opportunity to focus on learning words as opposed to pictures. Users who require images should bypass this Level and access Level 10.',
      'level10 How do we achieve this':
          'The Parent/Teacher/Specialist will have an understanding of the favourite words selected by the User. Data will also assist in gathering such details. All words have been set up to show a large image with a small defined word below (show example). The Parent/Teacher/Specialist will now gradually reduce the size of the picture for the favourite words, whilst increasing the size of the word. With time the Parent/Teacher/Specialist will aim to remove the image and only provide the User with the word. Once again, experience and data will provide feedback on the understanding of the User and their readiness to remove images from other buttons.',
      'level10 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program. If they are unable to use the words when the images have been reduced, this is a sign that the User is not ready for this Level and it must be revisited at another stage.',
      'How do you know ready for level 11':
          'How do you know the user is ready for level 11?',
      'level10 How do you know ready for level 11':
          'The User will show confidence in selecting icons with words as opposed to images. Data will continue to be available to show a high percentage success rate in identifying the chosen items.',
      'level11 name': 'predictive images/writing',
      'level11 summary':
          'This Level allows Users the opportunity to communicate with greater speed by providing the User with the opportunity to select predicted images or words. \n\nLearning outcome: The User will have the ability to communicate with the same confidence although at a greater speed and fluency.',
      'level11 Who does this level cater for':
          'This level caters for Users who have accessed Level 8.\n\nThis Level allows Users the opportunity to communicate with greater speed. ',
      'level11 How do we achieve this':
          'This Level provides the User with the opportunity to select predicted images or words. The App will provide a list of actions to be selected by the user. Once an action is selected, the pictures/words to be shown will be presented depending on the frequency of usage for each word. The most used words will appear higher in the grid while less used words for that specific action will appear lower on the grid.',
      'level11 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program',
    },
    // Bengali (261 million)
    'bn': {
      'app title': 'LUCAS',
      'relation': 'সম্পর্ক',
      'schedule day': 'সময়সূচী দিন',
      'sound': 'শব্দ',
      'video': 'ভিডিও',
      'story object': 'গল্প অবজেক্ট',
      'translation': 'অনুবাদ',
      'start': 'ব্যাকআপ শুরু করুন',
      'backup device': 'এই ডিভাইসটির ব্যাকআপ দিন',
      'Minimum level to show': 'ন্যূনতম স্তর দেখানোর জন্য',
      'background color': 'পেছনের রং',
      'loading empty spaces': 'খালি জায়গা লোড হচ্ছে',
      'loading translations': 'অনুবাদগুলি লোড হচ্ছে',
      'Drag and drop enabled': 'টানুন এবং ড্রপ সক্ষম হয়েছে',
      'Drag and drop disabled': 'টেনে আনুন এবং অক্ষম করুন',
      'about this app': 'এই অ্যাপ সম্পর্কে',
      'text to find': 'অনুসন্ধান',
      'text to find instructions':
          'প্রশ্নের শব্দটি খুঁজে পেতে শব্দ বা শব্দের অংশটি প্রবেশ করান। সবার সন্ধানে ফাঁকা রেখে দিন।',
      'number of concepts': 'ধারণার সংখ্যা',
      'one concept': 'একটি ধারণা',
      'two concepts': 'দুটি ধারণা',
      'three or more': 'তিন বা ততোধিক ধারণা',
      'students': 'শিক্ষার্থীরা',
      'find results': 'ফলাফলগুলি সন্ধান করুন',
      'result is correct': 'ফলাফল সঠিক',
      'result is wrong': 'ফলাফল ভুল',
      'play quiz': 'কুইজ শুনুন',
      'silent quiz ongoing': 'নীরব কুইজ চলছে',
      'send to device': 'পাঠানো:',
      'quiz type': 'কুইজের ধরণ',
      'quiz show image': 'চিত্রগুলি দেখান',
      'quiz sound image': 'ধারণাগুলি দেখুন',
      'quiz show sound and image': 'ধারণাগুলি এবং চিত্র দেখান',
      'quiz do not show anything': 'কিছু দেখাবেন না',
      'send quiz': 'কুইজ প্রেরণ করুন',
      'schedule_title1': 'স্বাগত',
      'schedule_title2': 'দিনের সময়',
      'schedule_title3': 'সম্পাদনা মোড',
      'schedule_title4': 'অবজেক্ট যুক্ত করুন',
      'schedule_title5': 'দিন পরিচালনা করুন',
      'schedule_text1':
          'তফসিলটি যা ঘটবে তা কল্পনা করতে দেয়। এটি আপনার ব্যবহারকারীকে বোঝার অনুমতি দেয় যে তিনি আজ এবং ভবিষ্যতে কী করবেন। আপনি কোনও আইটেমটি আরও বড় দেখতে টিপতে টিপতে পারেন।',
      'schedule_text2':
          'প্রতিটি ক্রিয়াকলাপটি ঘটবে এমন দিনের সময়টি লুকান / দেখান।',
      'schedule_text3':
          'সম্পাদনা মোড ধারণাগুলি পরিচালনা করতে দেয়। সম্পাদনা মোডে সমস্ত দিন প্রদর্শিত হবে এবং আপনি এটির সাথে ইন্টারঅ্যাক্ট করতে প্রতিটি বস্তুকে ক্লিক করতে পারেন।',
      'schedule_text4':
          'আপনি যে দিন / সময় এবং চিত্রটি প্রদর্শিত চান তা নির্বাচন করুন।',
      'schedule_text5':
          'আপনার যদি নতুন দিন যুক্ত করার প্রয়োজন হয় তবে এখানে ক্লিক করুন।',
      'existing concept':
          'ইতিমধ্যে একই দিন এবং ঘন্টা জন্য একটি ধারণা আছে। দয়া করে সংশোধন করে আবার চেষ্টা করুন।',
      'please select an object': 'দয়া করে একটি বিষয় নির্বাচন করুন',
      'please select a day': 'দয়া করে একটি দিন নির্বাচন করুন',
      'select an object': 'একটি বস্তু নির্বাচন করুন',
      'add object': 'সময়সূচীতে অবজেক্ট যুক্ত করুন',
      'select day': 'দিন নির্বাচন করুন',
      'selected day': 'নির্বাচিত দিন',
      'select hour': 'ঘন্টা নির্বাচন করুন',
      'monday': 'সোমবার',
      'tuesday': 'মঙ্গলবার',
      'wednesday': 'বুধবার',
      'thursday': 'বৃহস্পতিবার',
      'friday': 'শুক্রবার',
      'saturday': 'শনিবার',
      'sunday': 'রবিবার',
      'school': 'বিদ্যালয়',
      'home': 'বাড়ি',
      'today': 'আজ',
      'tomorrow': 'আগামীকাল',
      'no action required title': 'কোনও পদক্ষেপের প্রয়োজন নেই',
      'no action required info':
          'প্রদত্ত তথ্যটি পড়ুন এবং শিখুন আইকনে ক্লিক করে চালিয়ে যান',
      'reset': 'রিসেট',
      'video_title1': 'ভূমিকা ভিডিও',
      'video_title2': 'স্তর 1',
      'video_title3': 'স্তর 2',
      'video_title4': 'স্তর 3',
      'video_title5': 'স্তর 4',
      'video_title6': 'স্তর 5',
      'video_title7': 'স্তর 6',
      'video_title8': 'স্তর 7',
      'video_title9': 'স্তর 8',
      'video_title10': 'স্তর 9',
      'video_title11': 'স্তর 10',
      'video_title12': 'স্তর 11',
      'video_title13': 'ব্যবহারকারীর সেটিংস',
      'video_text1': 'আমাদের সূচনা ভিডিও',
      'video_text2': 'শক্তিশালী ভিডিও',
      'video_text3': 'পছন্দ ভিডিও',
      'video_text4': 'খারাপ পছন্দ ভিডিও',
      'video_text5': 'ভয়েস বক্স ভিডিও',
      'video_text6': 'ভোকাবুলারি ভিডিও তৈরি করা',
      'video_text7': 'ফোল্ডার ভিডিও তৈরি করা হচ্ছে',
      'video_text8': 'বাক্য গঠন - প্রথম এক ভিডিও',
      'video_text9': 'বাক্য গঠন - দুই অংশ ভিডিও',
      'video_text10': 'ব্যাকরণ এবং উন্নত সাক্ষরতার ভিডিও',
      'video_text11': 'শব্দের ভিডিও শেখা',
      'video_text12': 'ভবিষ্যদ্বাণীমূলক চিত্র / ভিডিও লেখার',
      'video_text13': 'ব্যবহারকারী সেটিংস ভিডিও',
      'showHelper_LevelSettings_title1': 'প্রথম:',
      'showHelper_LevelSettings_title2': 'তথ্য পূরণ করুন',
      'showHelper_LevelSettings_title3': 'স্তর পরিবর্তন করুন',
      'showHelper_LevelSettings_title4': 'পর্দা শেখা',
      'showHelper_LevelSettings_text1':
          'আমরা আপনার জন্য সরবরাহিত সমস্ত তথ্য পড়ুন দয়া করে',
      'showHelper_LevelSettings_text2':
          'কিছু স্তর আপনার পক্ষ থেকে তথ্য প্রয়োজন। তারা পরিষ্কারভাবে হাইলাইট করা হয়',
      'showHelper_LevelSettings_text3':
          'আপনার যদি স্তরগুলি পরিবর্তন করতে হয় তবে দয়া করে এই আইকন টিপুন',
      'showHelper_LevelSettings_text4':
          'একবার প্রস্তুত হয়ে গেলে, শিখুন স্ক্রিনে ফিরে যান',
      'showHelper_image-settings_title1': 'অনুসন্ধান',
      'showHelper_image-settings_title2': 'সম্পাদন করা',
      'showHelper_image-settings_title3': 'গ্রিড আকার',
      'showHelper_image-settings_title4': 'সাহায্য',
      'showHelper_image-settings_text1':
          'ছবিগুলি সন্ধান করতে পাঠ্যটি প্রবেশ করুন এবং বোতাম টিপুন',
      'showHelper_image-settings_text2': 'ছবিটি সম্পাদনা করতে ক্লিক করুন',
      'showHelper_image-settings_text3':
          'এই বোতামটি টিপে গ্রিডের আকার পরিবর্তন করুন',
      'showHelper_image-settings_text4':
          'এই বোতামটি ব্যবহার করে বা বন্ধ করতে সহায়তা টগল করুন',
      'showHelper_folders_title1': 'ক্লিক',
      'showHelper_folders_title2': 'ডবল ক্লিক করুন',
      'showHelper_folders_title3': 'দীর্ঘ চাপ',
      'showHelper_folders_title4': 'যোগ',
      'showHelper_folders_title5': 'প্যারেন্ট ফোল্ডারে ফিরে যান',
      'showHelper_folders_text1': 'একটি আইটেম এর বৈশিষ্ট্য দেখতে ক্লিক করুন',
      'showHelper_folders_text2':
          'একটি ফোল্ডার এর শিশুদের দেখতে ডাবল ক্লিক করুন',
      'showHelper_folders_text3':
          'কোনও আইটেমটিকে লক / আনলক করতে দীর্ঘক্ষণ টিপুন',
      'showHelper_folders_text4': 'ফোল্ডার, চিত্র, শব্দ এবং ভিডিও যুক্ত করুন',
      'showHelper_folders_text5':
          'প্যারেন্ট ফোল্ডারে ফিরে আসতে এই আইকনটি টিপুন',
      'Show Help Screens': 'সহায়তা স্ক্রিনগুলি দেখান',
      'privacy policy': 'গোপনীয়তা নীতি',
      'must accept privacy policy':
          'চালিয়ে যাওয়ার আগে আপনাকে অবশ্যই আমাদের গোপনীয়তা নীতি গ্রহণ করতে হবে',
      'view privacy policy': 'গোপনীয়তা নীতি দেখুন',
      'accept privacy policy': 'গোপনীয়তা নীতি গ্রহণ করুন',
      'show hide schedule': 'শিডিউল দেখান / লুকান',
      'show hide stories and schedule': 'গল্পগুলি এবং শিডিউলটি দেখান বা লুকান',
      'show': 'প্রদর্শনী',
      'hide': 'লুকান',
      'share item': 'ভাগ',
      'check connection': 'সংযোগ পরীক্ষা করুন',
      'not connected to internet':
          'দেখে মনে হচ্ছে আপনি ইন্টারনেটের সাথে সংযুক্ত নন',
      'user information': 'ব্যবহারকারীর তথ্য',
      'settings restrictions instructions':
          'কনফিগারেশন অ্যাক্সেস সীমাবদ্ধ করা যেতে পারে। ব্যবহারকারী যদি শেখার প্রক্রিয়া থেকে নিজেকে বিচ্যুত করে কনফিগারেশন আইকনে ক্লিক করার চেষ্টা করে তবে এটি কার্যকর। যখন কনফিগারেশন সীমাবদ্ধতা সক্ষম করা হয়, তখন একটি সাধারণ গাণিতিক সমস্যার উত্তর সরবরাহ করতে হবে। উত্তরটি সঠিক হলে কনফিগারেশন বিভাগে অ্যাক্সেস দেওয়া হবে। এই বিধিনিষেধ ব্যবস্থাটি পিতামাতাদের এবং শিক্ষকদের পাসওয়ার্ডগুলি মনে রাখার এবং ভাগ করার প্রয়োজন ছাড়াই কনফিগারেশন বিভাগে অ্যাক্সেসকে সীমাবদ্ধ করতে দেয়।',
      'settings password protected': 'সেটিংস সীমাবদ্ধতা',
      'settings password protected no': 'কোন সীমাবদ্ধতা',
      'settings password protected yes': 'গণিত উত্তর অনুরোধ',
      'delete linked device': 'সংযুক্ত ডিভাইস মুছুন',
      'confirm delete linked device':
          'আপনি কি লিঙ্কযুক্ত ডিভাইস মুছতে চান? আপনি যদি এটি মুছে ফেলেন তবে এটিকে আবার যুক্ত করতে আপনাকে পরে এটিকে আবার সংযুক্ত করতে হবে।',
      'echo device': 'এই ডিভাইসটি ভয়েসবক্স প্রতিধ্বনিত করবে',
      'device silent': 'এই ডিভাইসটি নীরব থাকবে',
      'device blocked': 'ডিভাইসটি এখন অবরুদ্ধ করা আছে।',
      'device unblocked': 'ডিভাইসটি অবরোধ মুক্ত করা হয়েছে।',
      'output voicebox to device': 'অন্য ডিভাইসে আউটপুট ভয়েস বক্স',
      'quizzes': 'ক্যুইজ',
      'quizzes instructions':
          'এই ডিভাইসে কুইজ তৈরি করা যেতে পারে (শিক্ষক / শিক্ষিকা হিসাবে) (যে কোনও ডিভাইসে কুইজের উত্তর দেওয়া যেতে পারে)',
      'can create quiz': 'কুইজ তৈরি করতে পারে',
      'can not create quiz': 'কুইজ তৈরি করতে পারে না',
      'invite rejected': 'আমন্ত্রণ বাতিল করে',
      'invite sent': 'আমন্ত্রণ প্রেরণ',
      'recieved invite': 'এর সাথে লিঙ্ক করার জন্য আপনি একটি আমন্ত্রণ পেয়েছেন',
      'accept': 'গ্রহণ করা',
      'ignore and dismiss': 'উপেক্ষা করুন এবং বরখাস্ত করুন',
      'invite confirmed': 'আমন্ত্রণ নিশ্চিত করা হয়েছে',
      'invite accepted': 'আমন্ত্রণ গ্রহণ দ্বারা গ্রহণ',
      'remember link other party':
          'মনে রাখবেন: অন্যান্য ডিভাইসে একই প্রক্রিয়াটি পুনরাবৃত্তি করুন।',
      'please enter remote email': 'অন্য পক্ষের ইমেল প্রবেশ করুন',
      'add new device': 'নতুন ডিভাইস যুক্ত করুন',
      'remote user email': 'দূরবর্তী ব্যবহারকারীর ইমেল',
      'remote user email instructions':
          'দুটি ডিভাইসের মধ্যে একটি লিঙ্ক তৈরি করতে, নিশ্চিত করুন যে উভয় ডিভাইস চালু আছে, ইন্টারনেটের সাথে সংযুক্ত রয়েছে, অ্যাপ্লিকেশনটি চলছে এবং সংযুক্ত ডিভাইসগুলির স্ক্রিন (এই স্ক্রিন) দেখাচ্ছে। লিঙ্ক স্থাপনটি অবশ্যই উভয় ডিভাইসে কার্যকর করা উচিত (প্রতিটি ডিভাইসটি অবশ্যই অন্য পক্ষের ইমেলটি প্রবেশ করাতে হবে)',
      'enter remote user email': 'দূরবর্তী ব্যবহারকারীর ইমেল প্রবেশ করান',
      'warning': 'সতর্কতা',
      'email or name not filled':
          'ইমেল বা নাম ভরাট নয়। নতুন ডিভাইসগুলি লিঙ্ক করার চেষ্টা করার আগে দয়া করে এই তথ্যটি সম্পূর্ণ করুন।',
      'email or name required for backup':
          'ইমেল বা নাম ভরাট নয়। ডিভাইসটি ব্যাকআপ করার চেষ্টা করার আগে দয়া করে এই তথ্যটি সম্পূর্ণ করুন।',
      'email or name required for restore':
          'পুনরুদ্ধার করার জন্য ইমেল প্রয়োজন',
      'start restore': 'পুনরুদ্ধার শুরু করুন',
      'replace folder': 'ফোল্ডার প্রতিস্থাপন করুন',
      'add to folder': 'ফোল্ডারে যুক্ত করুন',
      'what to do with folder':
          'প্রতিস্থাপন করা হবে যে স্থানীয় ফোল্ডার নির্বাচন করুন। কোনও ফোল্ডার পুনরুদ্ধার করার আগে এই ডিভাইসটিকে ব্যাকআপ করার পরামর্শ দেওয়া হয়েছে কারণ দূরবর্তী ফোল্ডারটি প্রতিস্থাপনের আগে স্থানীয় ফোল্ডারের সামগ্রীগুলি মুছে ফেলা হবে।',
      'choose folder to restore': 'পুনরুদ্ধার করতে ফোল্ডারটি চয়ন করুন',
      'quiz': 'পরীক্ষা',
      'linked devices': 'সংযুক্ত ডিভাইসগুলি',
      'no linked devices': 'কোনও লিঙ্কযুক্ত ডিভাইস যেখানে পাওয়া যায় নি',
      'change user name': 'ব্যবহারকারীর নাম পরিবর্তন করুন',
      'confirm change user name': 'আপনি কি ব্যবহারকারীর নাম পরিবর্তন করতে চান?',
      'user name': 'ব্যবহারকারীর নাম',
      'user name hint': 'ব্যবহারকারীর নাম লিখুন',
      'change user email': 'ইমেল পরিবর্তন করুন',
      'confirm change user email':
          'আপনি যদি ব্যবহারকারীর ইমেল পরিবর্তন করেন তবে আপনাকে ডিভাইসগুলি রিলিং করতে হবে (পিতা বা মাতা বা শিক্ষিকার এই ডিভাইসের লিঙ্কটি পুনরায় তৈরি করতে হবে)। আপনি কি অবিরত করতে চান?',
      'user email': 'ব্যবহারকারীর ইমেল',
      'user email instructions':
          'ব্যবহারকারীর দ্বারা ব্যবহৃত ইমেল প্রবেশ করান। এটি ব্যবহারকারীর কাছে না থাকলে এটি পিতামাতার ইমেল হতে পারে। এই ক্ষেত্রে শিক্ষকের বা শিক্ষকের ইমেলটি রাখবেন না। ইমেলটি প্রতিটি ব্যবহারকারীর অনন্য হিসাবে চিহ্নিত করতে ব্যবহৃত হয়। ইমেলটি সিঙ্কিং বা কুইজের জন্য ডিভাইসগুলি লিঙ্ক করতে ব্যবহৃত হয়।',
      'user email hint': 'ইমেইল প্রদান করুন',
      'toggle visibility for all': 'সমস্ত ধারণার দৃশ্যমানতা পরিবর্তন করুন',
      'item availability': 'আইটেম প্রাপ্যতা',
      'item availability instructions':
          'যদি কোনও আইটেম উপলব্ধ না হয়, আপনি এটি নির্দেশ করতে পারেন। অ উপলভ্য আইটেমগুলি চিত্রের উপরে একটি লাল এক্স দিয়ে দেখানো হবে',
      'is available': 'সহজলভ্য',
      'is not available': 'পাওয়া যায় না',
      'not available': 'পাওয়া যায় না',
      'available': 'সহজলভ্য',
      'delete story': 'গল্প মুছুন',
      'confirm delete story': 'আপনি কি গল্পটি মুছতে চান?',
      'level not enabled': 'স্তর সক্ষম নয়',
      'not enough data':
          'ভবিষ্যদ্বাণীপূর্ণ লেখা সক্ষম করা হয়নি কারণ পর্যাপ্ত ডেটা সংগ্রহ করা হয়নি',
      'image size': 'ছবির আকার',
      'text size': 'অক্ষরের আকার',
      'small': 'ছোট',
      'medium': 'মধ্যম',
      'large': 'বড়',
      'select video': 'ভিডিও নির্বাচন করুন',
      'selected video': 'নির্বাচিত ভিডিও:',
      'recording': 'রেকর্ড করা হচ্ছে ...',
      'story object instructions':
          'আপনি ধারণাগুলি সোয়াইপ করে উড়িয়ে দিতে পারেন। কিছুই মুছে ফেলা হবে না। (ধারণাগুলি কেবল সম্পাদনা মোডে মুছে ফেলা হয়)',
      'edit story name': 'গল্পের নাম সম্পাদনা করুন',
      'select this concept': 'এই ধারণাটি নির্বাচন করুন',
      'no story object instructions': '',
      'add story object': 'ধারণা যুক্ত করুন',
      'story name hint': 'গল্পের নাম লিখুন',
      'create new story': 'একটি নতুন গল্প তৈরি করুন',
      'no stories instructions':
          'গল্পগুলি আপনাকে নতুন ধারণাগুলির ব্যাখ্যা করতে ধারণাগুলিতে (চিত্র, শব্দ এবং ভিডিও) যোগদান করতে দেয়। উদাহরণস্বরূপ, আপনি চিড়িয়াখানায় একটি পরিদর্শন ব্যাখ্যা করতে পারেন যা শুরু করে ঝরনা, কাপড় পরা, প্রাতঃরাশ, গাড়িতে ভ্রমণ এবং প্রাণী দেখে by',
      'add story': 'গল্প যোগ করুন',
      'please confirm': 'দয়া করে নিশ্চিত করুন',
      'replace sound confirmation':
          'আপনি কি বিদ্যমান অডিওটি প্রতিস্থাপন করতে চান?',
      'replace': 'প্রতিস্থাপন করা',
      'voiceBoxSize': 'ভয়েস বক্স আকার',
      'big': 'বড়',
      'select sound': 'অডিও রেকর্ড করুন',
      'select sound instructions':
          'আপনি যে শব্দটি চান তা রেকর্ড করুন। ব্যবহারকারী যখন ছবিটিতে ক্লিক করেন তখন এই অডিওটি আবার প্লে করা যায়।',
      'delete': 'মুছে ফেলা',
      'delete confirmation':
          'আপনি এই বস্তুটি মুছতে চান তা নিশ্চিত করুন। এই অপারেশনটি অপরিবর্তনীয়।',
      'warning not user created':
          'সতর্কতা: এই অবজেক্টটি ডিফল্টরূপে অ্যাপ্লিকেশানের সাথে বান্ডিল হয়েছে। আপনি যদি এটি মুছে ফেলেন তবে পুনরুদ্ধার করার কোনও উপায় নেই এবং আপনাকে অবশ্যই প্রতিটি ভাষাতে এটির চিত্র এবং পাঠ্য সহ ম্যানুয়ালি যুক্ত করতে হবে।',
      'folder not empty will not delete':
          'মোছার আগে ফোল্ডারটি অবশ্যই খালি থাকতে হবে',
      'local device': 'যন্ত্র',
      'library': 'গ্রন্থাগার',
      'camara': 'ক্যামেরা',
      'folder should talk': 'ফোল্ডারের নাম বলুন',
      'folder should talk instructions':
          'আপনি যদি ফোল্ডারে ক্লিক করার সময় এর নাম শুনতে চান তবে সক্ষম করুন।',
      'loading images': 'চিত্রগুলি লোড হচ্ছে',
      'loading folders': 'ফোল্ডারগুলি লোড হচ্ছে',
      'loading relations': 'সম্পর্ক লোড হচ্ছে',
      'loading categories': 'বিভাগ লোড হচ্ছে',
      'loading videos': 'ভিডিও লোড হচ্ছে',
      'loading sounds': 'শব্দ লোড হচ্ছে',
      'allowLongPressInLearningScreen':
          'লার্নিং মোডে একটি ধারণাকে দীর্ঘক্ষণ চাপ দেওয়ার অনুমতি দিন',
      'long press instructions':
          'লার্নিং মোডে, ব্যবহারকারী যদি দীর্ঘকাল ধরে একটি ধারণা চাপেন, তবে নির্বাচিত বিকল্পটির বিস্তারিত তথ্য উপস্থাপন করে একটি পর্দা প্রদর্শিত হবে।',
      'Not assigned': 'নির্ধারিত না',
      'nothing unlocked': 'কিছুই আনলক করা নেই',
      'nothing unlocked instructions':
          'এই গ্রিডটি ব্যবহার করার আগে, আপনার যে ধারণাগুলি চান তা অবশ্যই নির্বাচন করুন (প্রদর্শন / আনলক করুন)। ধারণাগুলি টিপে রেখে লক / আনলক করুন। মনে রাখবেন যে ফোল্ডারগুলি এই স্তরে প্রদর্শিত হয় না।',
      'please unlock':
          'আপনার কনফিগারেশন, ফোল্ডারগুলিতে আপনি যে আইটেমগুলি চান তা আনলক করুন / দৃশ্যমান করুন',
      'default folder': 'ডিফল্ট ফোল্ডার',
      'open folders': 'ফোল্ডার খুলুন',
      'default folder instructions':
          'ডিফল্ট ফোল্ডার হিসাবে এই ফোল্ডারটি নির্বাচন করতে, বোতামটি ক্লিক করুন',
      'understood': 'বোঝা',
      'not understood': 'বোঝা যায় না',
      'is understood': 'ধারণাটি বোঝা যাচ্ছে',
      'is not understood': 'ধারণাটি এখনও বোঝা যায় নি',
      'conceptIsUnderstood': 'ধারণা ধারণা',
      'conceptIsUnderstoodInstructions':
          'ব্যবহারকারীর স্পষ্ট ধারণাটি পরে, এটি বোঝা হিসাবে চিহ্নিত করুন। এটি শিক্ষক এবং পিতামাতাকে যোগাযোগ করতে সহায়তা করে। সমস্ত ধারণাগুলি বোঝা লার্নিং গ্রিডে সবুজ রঙে ফ্রেমযুক্ত।',
      'object visible': 'অবজেক্টটি বর্তমানে দৃশ্যমান',
      'object not visible': 'অবজেক্টটি বর্তমানে দৃশ্যমান নয়',
      'visibility': 'দৃষ্টিপাত',
      'visibility instructions':
          'আপনার ইচ্ছামত চিত্রগুলি দেখান বা লুকান (আনলক / লক করুন)',
      'image to show': 'চিত্র দেখানোর জন্য',
      'text to show': 'দেখানোর জন্য পাঠ্য',
      'text to show instructions':
          'এটি লার্নিং গ্রিডে প্রতিটি চিত্রের নীচে প্রদর্শিত পাঠ্য।',
      'text to show hint': 'দেখানোর জন্য পাঠ্য প্রবেশ করান',
      'text to say': 'বলার জন্য পাঠ্য',
      'text to say instructions':
          'কী বলতে হবে তা বদলাতে পারবেন! "আমার নাম ..." বলার পরিবর্তে আপনি এটিকে "আমার নাম হয় [নামটি এখানে রাখুন]" বা "আমার বোনটি [বোনের নাম]" এ পরিবর্তন করতে পারেন। প্রদর্শন করার জন্য একটি সংক্ষিপ্ত পাঠ্য থাকাও একটি দীর্ঘ পাঠ্য হিসাবে দরকারী, যেমন কোনও চিত্র যখন একটি দীর্ঘ বাক্যাংশ উপস্থাপন করে।',
      'text to say hint': 'বলতে পাঠ্য প্রবেশ করুন',
      'edit': 'সম্পাদন করা',
      'no default folder': 'ডিফল্ট ফোল্ডার নির্বাচন করা হয়নি',
      'please select a default folder':
          'একটি ডিফল্ট ফোল্ডার নির্বাচন করুন। কেবলমাত্র সেই ফোল্ডারটি থেকে আপনি আনলক করা চিত্রগুলি প্রদর্শিত হবে।',
      'select folder': 'ডিফল্ট ফোল্ডারটি নির্বাচন করুন',
      'select a folder':
          'আপনি আমদানি করতে চান এমন রিমোট ফোল্ডারটি নির্বাচন করুন',
      'current default folder': 'বর্তমান ডিফল্ট ফোল্ডার:',
      'unlock': 'আনলক',
      'lock': 'লক',
      'debug mode': 'সংশোধনের ধাপ',
      'user profile': 'ব্যবহারকারীর সেটিংস',
      'add': 'যোগ',
      'Grid size': 'গ্রিড আকার',
      'grid size instructions':
          'আপনি যদি চান তবে গ্রিডের আকার (কলাম এবং সারি) পরিবর্তন করতে পারেন। আপনার যদি একটি বড় স্ক্রিনযুক্ত কোনও ডিভাইস থাকে তবেই এই সেটিংটি পরিবর্তন করুন। যাচাই করুন যে ব্যবহ��রকারী প্রতিটি আইকন স্বাচ্ছন্দ্যে দেখতে এবং স্পর্শ করতে পারে।',
      'operation completed successfully': 'অপারেশন সফলভাবে শেষ হয়েছে',
      'restore device': 'ডিভাইস পুনরুদ্ধার করুন',
      'user email to restore': 'পুনরুদ্ধার করতে ব্যবহারকারীর ইমেল',
      'categories': 'ধরন',
      'category': 'বিভাগ',
      'close': 'ঘনিষ্ঠ',
      'add folder': 'ফোল্ডার যোগ করুন',
      'add image': 'ছবি সংযুক্ত কর',
      'add empty': 'খালি স্থান যুক্ত করুন',
      'add video': 'ভিডিও যোগ করুন',
      'add sound': 'শব্দ যোগ করুন',
      'new folder name': '',
      'new image name': '',
      'new video name': '',
      'new sound name': '',
      'show folder': 'ফোল্ডার দেখান',
      'hide folder': 'ফোল্ডারটি লুকান',
      'delete folder': 'ফোল্ডার মুছুন',
      'folder instructions':
          'কোনও ছবিতে ক্লিক করুন বা ডাবল ক্লিক করুন অথবা এর বিকল্পগুলি সক্রিয় করতে একটি ফাঁকা জায়গা। আরও বিকল্প অনুসন্ধান করতে মেনুতে ক্লিক করুন।',
      'grid instructions':
          'ব্যবহারকারীর প্রয়োজনের (বৃহত্তর আইকনগুলির জন্য) বা ডিভাইসের স্ক্রিনের আকারের উপর নির্ভর করে আপনি স্তর 5 থেকে শুরু হওয়া চিত্রগুলির গ্রিড আকার পরিবর্তন করতে পারেন।',
      'grid': 'গ্রিড',
      'Columns': 'কলাম',
      'Rows': 'সারি',
      'folders': 'ফোল্ডার',
      'level not found': 'স্তর খুঁজে পাওয়া যায় নি',
      'missing reinforcer': 'নিখোঁজ পুনর্বহালকারী',
      'confirm reinforcer': 'আপনি ব্যবহার করতে চান দয়া করে নিশ্চিত করুন ',
      'selected reinforcer':
          'আপনার বর্তমান নির্বাচিত পুনরায় প্রয়োগকারী হ\'ল:',
      'please select a reinforcer':
          'দয়া করে এই স্তরের জন্য একটি সংশোধনকারী নির্বাচন করুন',
      'cancel': 'বাতিল',
      'learn': 'শেখা',
      'stories': 'গল্পসমূহ',
      'schedule': 'তফসিল',
      'help videos': 'সহায়তা ভিডিও',
      'images': 'চিত্র',
      'colors': 'রং',
      'amber': 'অ্যাম্বার',
      'blue': 'নীল',
      'cyan': 'সায়ান',
      'deepOrange': 'গভীর কমলা',
      'deepPurple': 'গভীর বেগুনি',
      'green': 'সবুজ',
      'indigo': 'বেগনি নীলবর্ণ',
      'lightBlue': 'হালকা নীল',
      'lightGreen': 'হালকা সবুজ',
      'lime': 'চুন',
      'orange': 'কমলা',
      'pink': 'পরাকাষ্ঠা',
      'purple': 'রক্তবর্ণ',
      'red': 'লাল',
      'teal': 'ক্ষুদ্র হংস',
      'yellow': 'হলুদ',
      'dark mode': 'গা .় মোড',
      'select this theme': 'এই থিমটি নির্বাচন করুন',
      'select voice': 'ভয়েস নির্বাচন করুন',
      'no voice selected':
          'কোনও ভয়েস নির্বাচিত হয়নি। আপনি যদি কোনও ভয়েস নির্বাচন না করেন তবে অ্যাপ্লিকেশন কোনও শব্দ বলতে সক্ষম হবে না।',
      'tts': 'পাঠ্য থেকে স্পিচ',
      'voice speed': 'ভয়েস গতি',
      'say': 'জোরে বলে',
      'send by email': 'ইমেইলের মাধ্যমে প্রেরিত',
      'user name not configured': 'ব্যবহারকারীর নাম কনফিগার করা হয়নি',
      'change': 'পরিবর্তন',
      'no valid voice found': 'কোনও বৈধ ভয়েস পাওয়া যায় নি',
      'test voice': 'ভয়েস পরীক্ষা করুন। সক্রিয় করতে ক্লিক করুন।',
      'test text':
          'আপনি যদি এই বাক্যটি শুনতে পান তবে আপনি ভয়েসটি সঠিকভাবে কনফিগার করেছেন।',
      'settings title': 'কনফিগারেশন',
      'levels': 'মাত্রা',
      'language': 'ভাষা',
      'select language instructions': 'আপনার পছন্দসই ভাষা নির্বাচন করুন',
      'Chinese': 'চীনা',
      'English': 'ইংরেজি',
      'Hindi': 'হিন্দি',
      'Spanish': 'স্পেনীয়',
      'Arabic': 'আরবি',
      'Malay': 'মালে',
      'Russian': 'রাশিয়ান',
      'Bengali': 'বাংলা',
      'Portuguese': 'পর্তুগীজ',
      'French': 'ফরাসি',
      'German': 'জার্মান',
      'find image': 'চিত্রটি সন্ধান করুন',
      'selected level': 'নির্বাচিত স্তর',
      'level1': 'স্তর 1',
      'level2': 'স্তর 2',
      'level3': 'স্তর 3',
      'level4': 'স্তর 4',
      'level5': 'স্তর 5',
      'level6': 'স্তর 6',
      'level7': 'স্তর 7',
      'level8': 'স্তর 8',
      'level9': 'স্তর 9',
      'level10': 'স্তর 10',
      'level11': 'স্তর 11',
      'change level': 'স্তর পরিবর্তন করুন',
      'summary': 'সারাংশ',
      'level1 name': 'বলবত্কারী',
      'level1 summary':
          'সএই স্তরের প্রাথমিক কাজটি হল ব্যবহারকারীকে স্ক্রিন স্পর্শ করতে উদ্বুদ্ধ করা। ব্যবহারকারী যখন কোনও বস্তুর জন্য অনুরোধ করতে স্বাধীনভাবে স্ক্রিনটি স্পর্শ করে তখন শেখার ফলাফল অর্জন করা হয়।',
      'Who does this level cater for': 'এই স্তরটি কে পূরণ করে?',
      'level1 Who does this level cater for':
          'শূন্য যোগাযোগের মধ্যে সীমাবদ্ধ সহ একটি শিশু বা প্রাপ্তবয়স্ক। এই স্তরের প্রাথমিক কাজটি হ'
              'ল অ্যাপ / ডিভাইস দ্বারা ব্যবহারকারীকে অনুপ্রাণিত করতে উত্সাহিত করা',
      'How do we achieve this?': 'আমরা কিভাবে এটা অর্জন করব?',
      'level1 How do we achieve this':
          'পিতা-মাত��� / শিক্ষক / বিশেষজ্ঞকে অবশ্যই সন্তানের পুনরুদ্ধারকারী সম্পর্কে সচেতন হতে হবে। একটি পুনর্বহালকারী হ'
              'ল একটি বস্তু বা আইটেম যা ব্যবহার���ারী উপভোগ করেন বা এতে অশ্লীল হয়ে পড়ে। এর একটি ভাল উদাহরণ হ'
              'ল চকোলেট জাতীয় খাবারের আইটেম।',
      'select reinforcer': 'সংশোধনকারী নির্বাচন করুন',
      'How do we get the user to touch the screen?':
          'আমরা কীভাবে ব্যবহারকারীর পর্দা স্পর্শ করতে পারি?',
      'level1 How do we get the user to touch the screen':
          'স্তর 1 এক স্ক্রিন / বোতাম হিসাবে সেট আপ করা হয়েছে যা স্পর্শ হওয়ার সাথে সাথে কথা বলে। চকোলেট উদাহরণ ব্যবহার করে, একজন পিতামাতা / শিক্ষক / বিশেষজ্ঞের চকোলেট চিত্রটি দেখানোর জন্য অ্যাপটি সেট আপ করা উচিত। অভিভাবক / শিক্ষক / বিশেষজ্ঞকে প্রতিটি শিক্ষণ সেশনের সময় অনেক ছোট ছোট টুকরো চকোলেট রেখে প্রস্তুত করা উচিত যা ব্যবহারকারীর তাত্ক্ষণিক পুরষ্কার সরবরাহ করতে পারে। মনে রাখবেন, অধ্যাপনা অধিবেশনগুলির জন্য সময় নির্ধারণ করা গুরুত্বপূর্ণ, তবে দিনের প্রতিটি মুহূর্ত একটি শিক্ষণ সুযোগ হতে পারে। আইপ্যাড এমন জায়গায় রাখুন যেখানে ব্যবহারকারীর এটি ব্যবহারের প্রতিটি সুযোগ থাকতে পারে। teaching \n\n আপনার পাঠদান অধিবেশন চলাকালীন \n1। ব্যবহারকারীকে একটি ছোট টুকরো চকোলেট সরবরাহ করুন। ব্যবহারকারী বসা সবচেয়ে ভাল, যদিও এটি সর্বদা সম্ভব নাও হতে পারে \n2 । স্ক্রিনটি স্পর্শ করতে ব্যবহারকারীকে উত্সাহিত করতে ‘হাতের মুঠোয়’ ব্যবহার করুন। ‘হ্যান্ড হ্যান্ড হ্যান্ড’ একটি শিক্ষণ পদ্ধতি যা অটিস্টিক শিশুদের সাথে ব্যবহৃত হয়। পিতা-মাতা / শিক্ষক / বিশেষজ্ঞ ব্যবহারকারীকে তাকে বোতাম টিপে উত্সাহিত করে সহায়তা করে। পিতামাতা / শিক্ষক / বিশেষজ্ঞ তাদের হাত ব্যবহারকারীর হাতের উপরে রাখে এবং তাদের নির্বাচিত বোতামের দিকে নির্দেশ দেয়। * \n3। অ্যাপ্লিকেশন কথা বলার সাথে সাথে পিতামাতা / শিক্ষক / বিশেষজ্ঞকে তাত্ক্ষণিকভাবে ব্যবহারকারীকে চকোলেট দিতে হবে \n4 । ব্যবহারকারী হতাশ না হয়ে এটিকে নিয়মিত 5 মিনিট অবধি পর্যালোচনা করা উচিত। ব্যবহারকারী যতটা হতাশ হোন ততক্ষণ বোতামটি চাপ না দেওয়া পর্যন্ত তাকে চকোলেট সরবরাহ করবেন না \n5 । ব্যবহারকারী হতাশ হয়ে পড়লে হাল ছাড়বেন না। এটি একটি দীর্ঘ প্রক্রিয়া, তবে দীর্ঘমেয়াদী লাভগুলি ব্যবহারকারীকে জীবনের জন্য সেট আপ করবে। ব্যবহারকারী শান্ত হলে এই কার্যটি থামান এবং পুনরায় দর্শন করুন \n\n সারা দিন নিয়মিত বিরতিতে 1-5 পদক্ষেপটি পুনরাবৃত্তি করুন। অনেক ব্যবহারকারী এই স্তরে সাফল্যের জন্য খুব দ্রুত হবে এবং অন্যরা প্রচুর পরিশ্রম, ধৈর্য এবং প্রচেষ্টা গ্রহণ করবে \n\n * এই সহায়তার শক্তি ধীরে ধীরে হ্রাস করা উচিত। পুরোপুরি সরাতে কয়েক মাস সময় নিতে পারে।',
      'How do you know ready for level 2':
          'আপনি কীভাবে জানবেন যে ব্যবহারকারী স্তর 2 এর জন্য প্রস্তুত?',
      'level1 How do you know ready for level 2':
          'ব্যবহারকারী "হ্যান্ড হ্যান্ড হ্যান্ড" এর প্রয়োজনীয়তা হ্রাস করবে কারণ আপনি লক্ষ্য করেছেন যে আপনার শিশু এই অ্যাপ্লিকেশনটি বুঝতে শুরু করে তাদের তাদের পুনর্বহালকারী পেতে সহায়তা করে। ব্যবহারকারী যখন পিতামাতা / শিক্ষকের কোনও সমর্থন ছাড়াই স্বাধীনভাবে এবং ধারাবাহিকভাবে বোতামটি চাপছেন, ব্যবহারকারী স্তর 2 এর জন্য প্রস্তুত',
      'level2 name': 'গ্রেপ্তার',
      'level2 summary':
          'এই স্তরটি ব্যবহারকারীকে শেখানোর জন্য তৈরি করা হয়েছে যে ফলস্বরূপ ফলাফলের জন্য একাধিক বিকল্প রয়েছে। । \n\n শিখুন ফলাফল: ব্যবহারকারীর উভয় আইটেমকে ধারাবাহিকভাবে এবং বোঝার সাথে অনুরোধ করার ক্ষমতা থাকবে।',
      'level2 Who does this level cater for':
          'এই স্তরটি এমন ব্যবহারকারীদের জন্য পরিবেশন করে যাঁরা 1 স্তরের অ্যাক্সেস পেয়েছেন এবং \'হ্যান্ড হ্যান্ড হ্যান্ড\'-এর ন্যূনতম প্রয়োজন। ব্যবহারকারীর দুটি বিকল্প দেওয়া হচ্��ে যা তাদের পছন্দ করতে উত্সাহ দেয় prog',
      'level2 How do we achieve this':
          'পিতা / মাতা / শিক্ষক / বিশেষজ্ঞকে অবশ্যই নিশ্চিত করতে হবে যে দ্বিতীয় চিত্রটি পর্দায় যুক্ত হচ্ছে এটি দ্বিতীয় পুনরুদ্ধারকারী, উদাহরণস্বরূপ, রস। ব্যবহারকারীর কাছে এখন তাদের দুটি পছন্দসই আইটেম অনুরোধ করার বিকল্প থাকবে এবং এটি অ্যাপের সাথে তাদের সম্পর্ক তৈরি করবে।',
      'select second reinforcer': 'দ্বিতীয় সংশোধনকারী নির্বাচন করুন',
      'level2 How do we get the user to touch the screen':
          'পিতা বা মাতা / শিক্ষক / বিশেষজ্ঞ স্তর 1 তে নিযুক্ত একই কৌশল ব্যবহার করবেন সংক্ষেপে, দুটি আইটেম অবশ্যই অনায়াসে পাওয়া উচিত এবং অনুরোধের সাথে সাথে ব্যবহারকারীকে সরবরাহ করতে হবে। এটি নিশ্চিত করা গুরুত্বপূর্ণ যে ব্যবহারকারী সঠিক আইটেমটি পাচ্ছেন এবং দুটি চিত্রের মধ্যে পার্থক্য সম্পর্কে সচেতন। ব্যবহারকারীর আইটেমগুলির মধ্যে একটিতে প্রদর্শিত হওয়া উচিত এবং অবশ্যই এটি নির্ভুল এবং ধারাবাহিকভাবে অনুরোধ করতে হবে। ডেটা প্রতিক্রিয়া হাইলাইট এবং নির্ভুলতা প্রদর্শন করতে উপলব্ধ হবে। এই স্তরটি অগ্রগতির দ্রুততম স্তরের একটি, কারণ ইতিমধ্যে 1 স্তরের পুনর্বহালকারী দ্বারা ব্যবহারকারীকে অনুপ্রাণিত করা উচিত।',
      'How do you know ready for level 3':
          'আপনি কীভাবে জানবেন যে ব্যবহারকারী 3 স্তরের জন্য প্রস্তুত?',
      'level2 How do you know ready for level 3':
          'ব্যবহারকারী স্বাধীনভাবে অ্যাপটি ব্যবহারের ক্ষেত্রে উন্নত আস্থা প্রদর্শন করবে এবং ‘হ্যান্ড হ্যান্ড হ্যান্ড’ এর প্রয়োজনের সীমিত দরকার হওয়া উচিত। ব্যবহারকারী যখন পিতামাতা / শিক্ষক / বিশেষজ্ঞের সীমিত সহায়তায় স্বতন্ত্র এবং ধারাবাহিকভাবে বোতামগুলি চাপ দিচ্ছেন, তখন এটি একটি চিহ্ন যে ব্যবহারকারী 3 স্তরের জন্য প্রস্তুত।',
      'level3 name': 'খারাপ পছন্দ',
      'level3 summary':
          'এই পর্যায়ে ব্যবহারকারী বুঝতে পারবেন যে অ্যাপটি একটি ফলাফল সরবরাহ করে যা তাকে আনন্দ দেয়। এই অগ্রগতিটি ব্যবহারকারীকে শেখায় যে সমস্ত স্তর পুরষ্কারযুক্ত নয় তবে তারা যোগাযোগ this এই স্তরটি স্বল্প সময়ের মধ্যে অর্জিত হয়। শিক্ষার ফলাফল: ব্যবহারকারীর অ-পছন্দসই বিকল্পটি প্রাপ্তিতে বিরক্তি প্রদর্শন করতে হবে। ব্যবহারকারী আর এই বিকল্পটি পছন্দ করবে না।',
      'level3 Who does this level cater for':
          'এই স্তরটি এমন ব্যবহারকারীদের জন্য পরিবেশন করে যাঁরা 1 এবং 2 স্তরের অ্যাক্সেস করেছেন এবং তাদের হাতে \'হ্যান্ড ওভার\' করার জন্য ন্যূনতম / শূন্য প্রয়োজন। ব্যবহারকারীর তৃতীয় বিকল্পের প্রস্তাব দিয়ে অগ্রগতি হয় যা অনুকূল পছন্দ নয়।',
      'level3 How do we achieve this':
          'উন্নয়নের এই পর্যায়ে, ব্যবহারকারীর কাছে এখন একটি অ-পছন্দসই বিকল্প থাকবে। পিতামাতা / শিক্ষক / বিশেষজ্ঞকে অবশ্যই নিশ্চিত করতে হবে যে স্ক্রিনে তৃতীয় চিত্র যুক্ত করা হচ্ছে অ-পছন্দসই আইটেম, উদাহরণস্বরূপ, একটি মোজা। ব্যবহারকারীর কাছে এখন দুটি পছন্দসই বিকল্প এবং একটি অ-পছন্দসই বিকল্পের জন্য অনুরোধ করার বিকল্প থাকবে।',
      'select third reinforcer': 'তৃতীয় শব্দটি নির্বাচন করুন',
      'level3 How do we get the user to touch the screen':
          'ব্যবহারকারীর এখন অ্যাপ্লিকেশন দ্বারা অনুপ্রাণিত করা উচিত এবং চিত্রগুলি স্পর্শ করতে আগ্রহী হবে। তারা আজ পর্যন্ত চিত্রগুলি থেকে আনন্দ পেয়েছে। ব্যবহারকারী জিজ্ঞাসাবাদী হবে এবং পছন্দ না করা আইটেম থেকে একটি ইতিবাচক ফলাফল পেতে ইচ্ছুক উচিত। পিতামাতা / শিক্ষক / বিশেষজ্ঞের কাছ থেকে উদ্দীপনা ছাড়াই তাকে প্রেরণা দেওয়া উচিত, তবে যদি এটি না হয় তবে অভিভাবক / শিক্ষক / বিশেষজ্ঞের এই মিথস্ক্রিয়াকে উত্সাহিত করার জন্য স্তর 1 থেকে কৌশল অবলম্বন করা উচিত। যদি ব্যবহারকারী তিনটি চিত্রের যে কোনও একটি নির্বাচন করে / স্পর্শ করে তবে তারা তত্ক্ষণাত আইটেমটি গ্রহণ করবে। প্রথম তিনটি স্তর ব্যবহারকারীকে কীভাবে কোনও আইটেমের অনুরোধ ���রবেন তা শেখানোর জন্য ডিজাইন করা হয়েছে। এই স্তরটি এই সত্যকে সংহত করে যে সমস্ত পছন্দ আনন্দদায়ক নয়, তারা অনুরোধ। ব্যবহারকারীরা এখন তাদের বিবেচনা করতে শিখবে যে তারা যে চিত্রগুলি স্পর্শ করে সেগুলি তাদের প্রাপ্ত আইটেম হবে যা তারা তাদের পছন্দ হোক না কেন তা বিবেচনা না করেই receive',
      'How do you know ready for level 4':
          'আপনি কীভাবে জানবেন যে ব্যবহারকারী 4 স্তরের জন্য প্রস্তুত?',
      'level3 How do you know ready for level 4':
          'ব্যবহারকারী অ-পছন্দসই আইটেমটি গ্রহণ করার সময় হতাশা প্রদর্শন করবে এবং অনুরোধ করা অন্যান্য আইটেমগুলিতে সন্তুষ্ট থাকবে। অভিভাবক / শিক্ষক / বিশেষজ্ঞের স্বতন্ত্রভাবে অ্যাপটি ব্যবহারের ক্ষেত্রে উন্নত আত্মবিশ্বাসের পর্যবেক্ষণ চালিয়ে যাওয়া উচিত। যখন ব্যবহারকারী পিতামাতা / শিক্ষক / বিশেষজ্ঞের কোনও সমর্থন ছাড়াই স্বাধীনভাবে এবং ধারাবাহিকভাবে বোতামগুলি চাপ দিচ্ছেন, ব্যবহারকারী 4 স্তরের জন্য প্রস্তুত is তথ্য এই পর্যবেক্ষণগুলি প্রমাণ করবে। ব্যবহারকারীর অ-পছন্দসই বিকল্প প্রাপ্তির সাথে বিরূপ দেখাও লক্ষ্য করা উচিত। ব্যবহারকারী আর এই বিকল্পটি পছন্দ করবে না।',
      'level4 name': 'ভয়েস বক্স',
      'level4 summary':
          'এই স্তরটি পরবর্তী স্তরগুলিতে ব্যবহৃত হবে এমন ভাষা কাঠামো তৈরি করা শুরু করার জন্য ডিজাইন করা হয়েছে। ব্যবহারকারীর জন্য পুরষ্কার কেবল তখনই দেওয়া হবে যখন সে চিত্রটি নির্বাচন করে এবং ভয়েস বক্সে স্পর্শ করবে। শিক্ষার ফলাফল: ব্যবহারকারী একটি নির্বাচিত আইটেম নির্বাচন করবেন এবং বুঝতে পারবেন যে সে / সে ভয়েস বাক্সটি স্পর্শ না করা পর্যন্ত আইটেমটি সরবরাহ করা হবে না।',
      'level4 Who does this level cater for':
          'এই স্তরটি এমন ব্যবহারকারীদের জন্য পরিবেশন করে যাঁরা 1-3 স্তরের অ্যাক্সেস পেয়েছেন এবং এখন ন্যূনতম / শূন্য ‘হ্যান্ড হ্যান্ড হ্যান্ড’ সমর্থন দিয়ে অ্যাপটি স্বাধীনভাবে ব্যবহার করছেন using এই স্তরটি পিতামাতা / শিক্ষক / বিশেষজ্ঞ এবং ব্যবহারকারীর জন্য হতাশার স্তরগুলির জন্য অন্যতম চ্যালেঞ্জের স্তর। এই স্তরের লক্ষ্য হ\'ল ব্যবহারকারীকে একটি ভয়েস বক্স ব্যবহার করতে শেখানো যা ভাষার বিকাশের জন্য অনুমতি দেয়। এই পর্যায়ে, পিতামাতা / শিক্ষক / বিশেষজ্ঞ ব্যবহারকারীকে দ্বি-শব্দের স্তর ব্যবহার করতে প্রস্তুত করার মাধ্যমে ভাষা বিকাশের পরিকল্পনা করছেন। চকোলেট চাই এই স্তরটি সময় এবং ধৈর্য লাগে। এটি স্বল্প সময়ের জন্য ‘হাতের মুঠোয়’ ফেরত যেতে পারে।',
      'level4 How do we achieve this':
          'এই পর্যায়ে, স্তরের 3 স্তরটি একই তিনটি বিকল্পের সাথে রয়ে গেছে যদিও পর্দার এখন পর্দার শীর্ষে একটি দীর্ঘ স্ট্রিপ রয়েছে। এই স্ট্রিপটিকে ‘ভয়েস বক্স’ হিসাবে উল্লেখ করা হয়। ব্যবহারকারী যখন সাধারণ চিত্রগুলিকে স্পর্শ করে, শব্দটি আর সঙ্গে সঙ্গে বলা হবে না। এটি এখন পর্দার শীর্ষে ভয়েস বক্সে প্রদর্শিত হবে। নির্বাচিত শব্দগুলি কথা বলতে সক্ষম করতে ব্যবহারকারীকে এখন ভয়েস বাক্সটি স্পর্শ করতে হবে।',
      'level4 How do we get the user to touch the screen':
          'আইটেমটির অনুরোধ করা হলে ব্যবহারকারী আর তাত্ক্ষণিক সন্তুষ্টি পাবেন না। তাকে / তাকে অবশ্যই ভয়েস বক্সটি স্পর্শ করতে উত্সাহিত করতে হবে। প্রাথমিকভাবে ব্যবহারকারীকে শেখাতে এবং কী প্রত্যাশা করা হয় তা দেখাতে এটির জন্য ‘হ্যান্ড হ্যান্ড হ্যান্ড’ প্রয়োজন। সমস্ত ব্যবহারকারী এটি আলাদা হারে শিখবে। পিতা / মাতা / শিক্ষক / বিশেষজ্ঞের ব্যবহারকারীর বোঝার উপর নির্ভর করে ধীরে ধীরে ‘হ্যান্ড ওভার’ হ্রাস করতে হবে।',
      'How do you know ready for level 5':
          'আপনি কীভাবে জানবেন যে ব্যবহারকারী 5 স্তরের জন্য প্রস্তুত?',
      'level4 How do you know ready for level 5':
          'ব্যবহারকারী স্বাধীনভাবে, বা ‘হাতের মুঠোয়’ সমর্থন করে আইটেমটি নির্বাচন করবে এবং ভয়েস বাক্সটি স্পর্শ করবে। ডেটা একটি উচ্চ শতাংশ সাফল্যের হার প্রদর্শ��� করবে।',
      'level5 name': 'শব্দকোষ সম্বৃদ্ধকরণ',
      'level 5 folders': 'ফোল্ডারগুলির আচরণ',
      'level 5 folder info':
          'ফোল্ডারগুলি এই স্তরে প্রদর্শিত হয় না। এটি ইচ্ছাকৃত তাই ব্যবহারকারী অন্য ফোল্ডারে নেভিগেট না করে স্তরটির উদ্দেশ্য থেকে বিচ্যুত হবে না',
      'level5 summary':
          'এই স্তরটি শিক্ষার প্রক্রিয়াটি প্রাথমিক লক্ষ্যটি ব্যবহারকারীর জন্য ভাষা তৈরির লক্ষ্য হিসাবে শুরু করা হয়। শিক্ষার ফলাফল: ব্যবহারকারীর একটি ফোল্ডারের মধ্যে 6 বা ততোধিক শব্দগুলির একটি স্পষ্ট বোঝা থাকবে।',
      'level5 Who does this level cater for':
          'This level caters for Users who have accessed Levels 1-4. Users will generally be using the App independently at this stage although some may require ‘hand over hand’ support. \n\nThis level is the start of the teaching process with the primary aim being to build language for the User. The parent/teacher/specialist role becomes more important at this stage as new words should now be introduced to the User, and the parent/teacher/specialist must select words that would be important to the User. The words must also be within the same category ie. using the example of chocolate would require building language for snack items, and the snack items must be those preferred by the User. The categories have been pre-arranged into folders and the words can be made visible as required. If the words/items are not currently available on the folder, the parent/teacher/specialist can take a photo and add them in.\n\nAt this stage, the parent/teacher/specialist must follow the guidance that is provided in the teaching section regarding the use of videos, cards and items. This level takes time and a lot of patience. ‘Hand over hand’ may continue until the User builds his/her confidence.',
      'level5 How do we achieve this':
          'The Parent/Teacher/Specialist section within the App provides detail on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. \n\nThis section includes:\n1.	Continuing to request items\n2.	Matching pictures\n3.	Matching picture to object\n4.	Matching picture to item',
      'level5 How do we get the user to touch the screen':
          'This level requires the User to focus and remain seated to improve communication and build vocabulary. It is unlikely that the User will be willing to engage and therefore it is essential that the main reinforcer is re-introduced. The main reinforcer discussed as an example in the previous summaries was chocolate. In this case the chocolate must be readily available throughout these sessions as the User will be motivated to work if they are provided with a reward. \n\nInitially, the User should be rewarded with their reinforcer after EVERY successful item has been requested ie. when matching every item, the User should be rewarded with a small treat such as a third of a chocolate button. Gradually reduce the reinforcer treat as the User becomes more confident. In time, the User will no longer require a reinforcer. \n\For many this may require ‘hand over hand’ to initially teach the User and show what is expected. All Users will learn this at a different rate. The parent/teacher/specialist should gradually reduce the ‘hand over hand’ depending on the understanding of the User.',
      'How do you know ready for level 6':
          'How do you know the user is ready for level 6?',
      'level5 How do you know ready for level 6':
          'The User will have developed words within this category ie. snacks. This category will continue to be known as the ‘snack’ folder. When a folder contains 6 or more items the User is ready to progress to Level 6. The User would be expected to select items independently although some Users may still prefer ‘hand over hand’ support at this time. Data will continue to be available to show a high percentage success rate in identifying the chosen items. ',
      'level6 name': 'Creating folders',
      'level6 summary':
          'This Level allows Users to develop their language by increasing folders. Folders are created to allow Users to compartmentalize different topics ie. food, transport, clothes. \n\nLearning outcome: The User will show confidence in selecting items. They will be able to move between a minimum of three folders with ease.',
      'level6 Who does this level cater for':
          'This level differs from the others in that it caters for two groups:\n1.	Users who have accessed levels 1-5. These Users will be developing in confidence and most will be using the App independently. Some Users may still require extra support with ‘hand over hand’. Do not discourage this as all Users will develop at a different rate – as confidence grows, the need for support will reduce. \n2.	This would be the suggested stage to introduce the App to Users with limited/zero communication who are visual learners with moderate to good understanding. The parent/teacher/specialist should familiarize themselves with the teaching strategies employed in Levels 1-5 to promote maximum progress and understanding.\n\nThis Level allows Users to develop their language by increasing folders. Folders are created to allow Users to compartmentalize different topics ie. food, transport, clothes. \n\nThe Users who have accessed Levels 1-5 should be engaged and have a clear understanding of what is expected of them. This level allows the parent/teacher/specialist to add different folders to increase the language/speech opportunities. Consider this level as being similar language development for any individual learning a new language. Typical language development starts with one word ie. juice, cat, car. The words come from different folders. We, at Lucas Education, have created a template of folders that we believe are essential for day-to-day communication.',
      'level6 How do we achieve this':
          'One additional folder will be made available to the existing folder in Level 5. For new Users, two folders will be available. The parent/teacher/specialist selects a second folder which contains items that are motivating to the User. When data shows that the User has clearly understood 5 words, the App with allow the opportunity to unlock 5 more words within this folder as well as another folder. \n\nThis process will continue as your User continues to develop and grow. This is a natural process and the same process that all individuals go through when learning to speak and communicate. Level 6 is on-going learning and development.   \n\nThe Parent/Teacher/Specialist section within the App provides further detail on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. Games will be available in due course.\n\nThis section includes:\n1.	Continuing to request items\n2.	Matching pictures\n3.	Matching picture to object\n4.	Matching picture to item',
      'level6 How do we get the user to touch the screen':
          'This Level continues to require the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the program on the move. Examples of such opportunities are when seated in the car or maybe your child enjoys sitting in their pram.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be motivated to work if they are provided with a reward. It is important however to reduce the frequency of the reward. As the language develops, the reinforcer should be reduced and removed.  \n\nThis may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication.',
      'How do you know ready for level 7':
          'How do you know the user is ready for level 7?',
      'level6 How do you know ready for level 7':
          'The User will show confidence in selecting items. They will be able to move between a minimum of three folders with ease. Data will continue to be available to show a high percentage success rate in identifying the chosen items.',
      'level7 name': 'Sentence structure – part one',
      'level7 summary':
          'This Level allows Users to develop sentence structure by introducing a sentence starter. Folders are predesigned to predict possible sentence starters for each folder. \n\nLearning outcome: The User will show confidence in selecting the sentence starter followed by the chosen item. The words will be activated by pressing the voicebox.',
      'level7 Who does this level cater for':
          'This level caters for Users who have accessed Level 6.\n\nThis Level allows Users to develop sentence structure by introducing a sentence starter. Folders are predesigned to predict possible sentence starters for each folder. The option is also available to personalise words.',
      'level7 How do we achieve this':
          'In the previous section, typical language development was discussed. This section takes language development to the next level. Children move from one word level to two. We, at Lucas Education achieve this by introducing sentence starters which vary depending on the folder. Examples of this would be as follows:\n1.	Food folder – I want chocolate……I do not want chocolate.\n2.	Animal folder – I hear cat\n3.	Transport folder – I see car.\n\nSimilar to Level 4, the User may become frustrated during the initial stages of this Level as they are now expected to include a word prior to what has been expected of them in previous levels. For many reinforcers must be introduced again to ensure that the User remains motivated. \n\nAs with the previous folder the words/images will be released when data proves that the User is capable of understanding and consistently includes the sentence starter before requests. Level 7 is on-going learning and development.   \n\nThe Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources.',
      'level7 How do we get the user to touch the screen':
          'This Level also requires the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the programme on the move. Examples of such opportunities are when seated in the car or maybe your child enjoys sitting in their pram.\n\nOnce both icons, namely the sentence starter and the requested item, are appearing in the voice box, the User must touch the voice box and the App will say the sentence for example “I want chocolate” At this point the parent/teacher will give the User what he/she is requesting. The voice box should not be activated until an action and an image are added. Both icons must be spoken in the one voice box; they cannot be selected and spoken independently.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be more motivated to work if they are provided with a reward. This may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication. ',
      'How do you know ready for level 8':
          'How do you know the user is ready for level 8?',
      'level7 How do you know ready for level 8':
          'The User will show confidence in selecting the sentence starter followed by the chosen item. Data will continue to be available to show a high percentage success rate in identifying the chosen items and more sentence starters will be unlocked to develop language further.',
      'level8 name': 'Sentence structure – part two',
      'level8 summary':
          'This level caters for Users who have accessed Level 7.\n\nThis Level allows Users to develop sentence structure by including a sentence closer. Folders are predesigned to predict possible sentence closers for each folder. The option is also available to personalise words.',
      'level8 Who does this level cater for':
          'This level caters for Users who have accessed Level 7.\n\nThis Level allows Users to develop sentence structure by including a sentence closer. Folders are predesigned to predict possible sentence closers for each folder. The option is also available to personalise words.',
      'level8 How do we achieve this':
          'In Level 5, typical language development was promoted and in Level 6 the sentence starters were added. This Level progresses language development to the next level by closing the sentences. We, at Lucas Education achieve this by providing predicted sentence closers which vary depending on the folder. Examples of this would be as follows:\n1.	Food folder – I want chocolate please\n2.	Animal folder – I hear cat\n3.	Transport folder – I see car.\n\nThe final part of the sentences can or cannot be used in conjunction with the action and objects. For example in some cases, the closing part can be used alone eg. All done!\n\nSimilar to Levels 4 and 7, the User may become a little frustrated during the initial stages of this Level as they are now expected to include a word following what has been expected of them in previous levels. For many, reinforcers must be introduced again to ensure that the User remains motivated. \n\nAs with the previous folder the words/images will be released when data proves that the User is capable of understanding and consistently includes the sentence closer after requests. Level 8 is on-going learning and development.\n\The Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. ',
      'level8 How do we get the user to touch the screen':
          'This Level also requires the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the programme on the move. Such opportunities could be made possible at snack time or perhaps when ordering food at a takeaway.\n\nWhen all three icons, namely the sentence starter, the requested item and the sentence closer, are appearing in the voice box, the User must touch the voice box and the App will say the sentence, for example “I want chocolate, please!”. At this point the parent/teacher will give the person what she/he is requesting. The voice box should not be activated until an action, an image and a closer are added. All three icons must be spoken in the one voice box; they cannot be selected and spoken independently.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be more motivated to work if they are provided with a reward. This may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication.',
      'How do you know ready for level 9':
          'How do you know the user is ready for level 9?',
      'level8 How do you know ready for level 9':
          'The User will show confidence in selecting the sentence starter followed by the chosen item and sentence closer. Data will continue to be available to show a high percentage success rate in identifying the chosen items and more sentence closers will be unlocked to develop language further. \n\nUsers at this Level are now capable of accessing Levels 9, 10 and 11. All three Levels are challenging and cater for higher functioning Users. These Levels do not have to taught in a sequential order, for example, the User may find difficulty in progressing through Levels 9 and 10, but may succeed in Level 11.',
      'level9 name': 'Grammar and developed literacy',
      'level9 summary':
          'This Level allows higher functioning Users the opportunity to focus on building sentence structure by developing literacy through use of conjunctions, connectives and pronouns.\nThis is an important building block to teaching the User how to read. \n\nTHIS IS ONE OF THE MORE CHALLENGING LEVELS.\n\nLearning outcome: The User will have the ability to communicate with confidence by linking words with conjunctives and using other literacy cues to develop language further.',
      'level9 Who does this level cater for':
          'This level caters for Users who have accessed Level 8.\n\nThis Level allows higher functioning Users the opportunity to focus on building sentence structure by developing literacy through use of conjunctions, connectives and pronouns.\n\nTHIS IS ONE OF THE MORE CHALLENGING LEVELS.',
      'level9 How do we achieve this':
          'The Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. \n\nData will also assist in gathering success criteria and in unlocking progressive language.',
      'level9 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program. ',
      'How do you know ready for level 10':
          'How do you know the user is ready for level 10?',
      'level9 How do you know ready for level 10':
          'The User is capable to access Level 10 directly from Level 8. All Levels can be used at the same time to develop language. Words will be unlocked when data dictates that the User is ready. ',
      'level10 name': 'Learning words',
      'level10 summary':
          'This Level allows higher functioning Users the opportunity to focus on learning words as opposed to pictures. This Level progresses by removing pictures and replacing them with the name/text of each object. This is the initial step in providing our non-verbal children with the opportunity to read.\n\nLearning outcome: The User will have the ability to communicate with the same confidence by using words as opposed to images.',
      'level10 Who does this level cater for':
          'This level caters for Users who have accessed Level 8 or 9.\n\nThis Level allows higher functioning Users the opportunity to focus on learning words as opposed to pictures. Users who require images should bypass this Level and access Level 10.',
      'level10 How do we achieve this':
          'The Parent/Teacher/Specialist will have an understanding of the favourite words selected by the User. Data will also assist in gathering such details. All words have been set up to show a large image with a small defined word below (show example). The Parent/Teacher/Specialist will now gradually reduce the size of the picture for the favourite words, whilst increasing the size of the word. With time the Parent/Teacher/Specialist will aim to remove the image and only provide the User with the word. Once again, experience and data will provide feedback on the understanding of the User and their readiness to remove images from other buttons.',
      'level10 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program. If they are unable to use the words when the images have been reduced, this is a sign that the User is not ready for this Level and it must be revisited at another stage.',
      'How do you know ready for level 11':
          'How do you know the user is ready for level 11?',
      'level10 How do you know ready for level 11':
          'The User will show confidence in selecting icons with words as opposed to images. Data will continue to be available to show a high percentage success rate in identifying the chosen items.',
      'level11 name': 'predictive images/writing',
      'level11 summary':
          'This Level allows Users the opportunity to communicate with greater speed by providing the User with the opportunity to select predicted images or words. \n\nLearning outcome: The User will have the ability to communicate with the same confidence although at a greater speed and fluency.',
      'level11 Who does this level cater for':
          'This level caters for Users who have accessed Level 8.\n\nThis Level allows Users the opportunity to communicate with greater speed. ',
      'level11 How do we achieve this':
          'This Level provides the User with the opportunity to select predicted images or words. The App will provide a list of actions to be selected by the user. Once an action is selected, the pictures/words to be shown will be presented depending on the frequency of usage for each word. The most used words will appear higher in the grid while less used words for that specific action will appear lower on the grid.',
      'level11 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program',
    },
    // Portuguese (229 million)
    'pt': {
      'app title': 'LUCAS',
      'relation': 'Relação',
      'schedule day': 'Dia da programação',
      'sound': 'Som',
      'video': 'Vídeo',
      'story object': 'Objeto de história',
      'translation': 'Tradução',
      'start': 'Iniciar backup',
      'backup device': 'Faça backup deste dispositivo',
      'Minimum level to show': 'Nível mínimo para mostrar',
      'background color': 'Cor de fundo',
      'loading empty spaces': 'Carregando espaços vazios',
      'loading translations': 'Carregando traduções',
      'Drag and drop enabled': 'Arrastar e soltar habilitado',
      'Drag and drop disabled': 'Arrastar e soltar desativado',
      'about this app': 'Sobre este aplicativo',
      'text to find': 'Encontrar',
      'text to find instructions':
          'Digite a palavra ou parte da palavra a ser encontrada na pergunta. Deixe em branco para procurar todos.',
      'number of concepts': 'Número de conceitos',
      'one concept': 'Um conceito',
      'two concepts': 'Dois conceitos',
      'three or more': 'Três ou mais conceitos',
      'students': 'Alunos',
      'find results': 'Encontre resultados',
      'result is correct': 'O resultado está correto',
      'result is wrong': 'Resultado incorreto',
      'play quiz': 'Ouça o questionário',
      'silent quiz ongoing': 'Questionário silencioso em andamento',
      'send to device': 'Enviar para:',
      'quiz type': 'Tipo de questionário',
      'quiz show image': 'Mostrar imagens',
      'quiz sound image': 'Pronuncie os conceitos',
      'quiz show sound and image': 'Pronuncie os conceitos e mostre imagens',
      'quiz do not show anything': 'Não mostre nada',
      'send quiz': 'Enviar questionário',
      'schedule_title1': 'Bem-vinda',
      'schedule_title2': 'Hora do dia',
      'schedule_title3': 'Modo de edição',
      'schedule_title4': 'Adicionar objeto',
      'schedule_title5': 'Gerenciar dias',
      'schedule_text1':
          'O cronograma permite visualizar as coisas que vão acontecer. Ele permite que o usuário entenda o que ele fará hoje e no futuro. Você pode pressionar e pressionar um item para ampliá-lo.',
      'schedule_text2':
          'Ocultar / mostrar a hora do dia em que cada atividade ocorrerá.',
      'schedule_text3':
          'O modo de edição permite gerenciar conceitos. No modo de edição, todos os dias serão mostrados e você pode clicar em cada objeto para interagir com ele.',
      'schedule_text4':
          'Selecione o dia / hora e a imagem que deseja que seja exibida.',
      'schedule_text5': 'Se você precisar adicionar novos dias, clique aqui.',
      'existing concept':
          'Já existe um conceito para o mesmo dia e hora. Corrija e tente novamente.',
      'please select an object': 'Por favor, selecione um objeto',
      'please select a day': 'Por favor selecione um dia',
      'select an object': 'Selecione um objeto',
      'add object': 'Adicionar objeto ao agendamento',
      'select day': 'Selecionar dia',
      'selected day': 'Dia selecionado',
      'select hour': 'Selecionar hora',
      'monday': 'Segunda-feira',
      'tuesday': 'Terça',
      'wednesday': 'Quarta-feira',
      'thursday': 'Quinta-feira',
      'friday': 'Sexta-feira',
      'saturday': 'Sábado',
      'sunday': 'Domingo',
      'school': 'Escola',
      'home': 'Casa',
      'today': 'Hoje',
      'tomorrow': 'Amanhã',
      'no action required title': 'Nenhuma ação é necessária',
      'no action required info':
          'Leia as informações fornecidas e continue clicando no ícone Aprender',
      'reset': 'Redefinir',
      'video_title1': 'Vídeo introdutório',
      'video_title2': 'Nível 1',
      'video_title3': 'Nível 2',
      'video_title4': 'Nível 3',
      'video_title5': 'Nível 4',
      'video_title6': 'Nível 5',
      'video_title7': 'Nível 6',
      'video_title8': 'Nível 7',
      'video_title9': 'Nível 8',
      'video_title10': 'Nível 9',
      'video_title11': 'Nível 10',
      'video_title12': 'Nível 11',
      'video_title13': 'Configurações do Usuário',
      'video_text1': 'Nosso vídeo introdutório',
      'video_text2': 'Vídeo do reforçador',
      'video_text3': 'Vídeo de escolhas',
      'video_text4': 'Vídeo de más escolhas',
      'video_text5': 'Vídeo da caixa de voz',
      'video_text6': 'Construindo vídeo de vocabulário',
      'video_text7': 'Criando pastas de vídeo',
      'video_text8': 'Estrutura da frase - parte um vídeo',
      'video_text9': 'Estrutura da frase - vídeo da segunda parte',
      'video_text10': 'Gramática e vídeo sobre alfabetização desenvolvida',
      'video_text11': 'Aprendendo palavras em vídeo',
      'video_text12': 'Imagens preditivas / gravação de vídeo',
      'video_text13': 'Vídeo de configurações do usuário',
      'showHelper_LevelSettings_title1': 'Primeiro:',
      'showHelper_LevelSettings_title2': 'Preencher informações',
      'showHelper_LevelSettings_title3': 'Alterar nível',
      'showHelper_LevelSettings_title4': 'Tela de aprendizagem',
      'showHelper_LevelSettings_text1':
          'Leia todas as informações que fornecemos para você',
      'showHelper_LevelSettings_text2':
          'Alguns níveis exigem informações do seu lado. Eles estão claramente destacados',
      'showHelper_LevelSettings_text3':
          'Se você precisar alterar os níveis, faça-o pressionando este ícone',
      'showHelper_LevelSettings_text4':
          'Quando estiver pronto, volte para a tela Aprender',
      'showHelper_image-settings_title1': 'Encontrar',
      'showHelper_image-settings_title2': 'Editar',
      'showHelper_image-settings_title3': 'Tamanho da grade',
      'showHelper_image-settings_title4': 'Socorro',
      'showHelper_image-settings_text1':
          'Digite o texto e pressione o botão para encontrar as imagens',
      'showHelper_image-settings_text2': 'Clique na imagem para editá-la',
      'showHelper_image-settings_text3':
          'Altere o tamanho da grade pressionando este botão',
      'showHelper_image-settings_text4':
          'Ativar ou desativar a ajuda usando este botão',
      'showHelper_folders_title1': 'Clique',
      'showHelper_folders_title2': 'Duplo click',
      'showHelper_folders_title3': 'Pressão longa',
      'showHelper_folders_title4': 'Adicionar',
      'showHelper_folders_title5': 'Voltar à pasta principal',
      'showHelper_folders_text1':
          'Clique em um item para ver suas propriedades',
      'showHelper_folders_text2':
          'Clique duas vezes em uma pasta para visualizar seus filhos',
      'showHelper_folders_text3':
          'Pressione e segure um item para bloqueá-lo / desbloqueá-lo',
      'showHelper_folders_text4': 'Adicione pastas, imagens, sons e vídeos',
      'showHelper_folders_text5':
          'Para retornar à pasta principal, pressione este ícone',
      'Show Help Screens': 'Mostrar telas de ajuda',
      'privacy policy': 'Política de Privacidade',
      'must accept privacy policy':
          'Você deve aceitar nossa política de privacidade antes de continuar',
      'view privacy policy': 'Ver política de privacidade',
      'accept privacy policy': 'Aceitar política de privacidade',
      'show hide schedule': 'Mostrar / ocultar agendamento',
      'show hide stories and schedule':
          'Mostrar ou ocultar as histórias e a programação',
      'show': 'Exposição',
      'hide': 'Ocultar',
      'share item': 'Compartilhar',
      'check connection': 'Verifique a conexão',
      'not connected to internet':
          'Parece que você não está conectado à Internet',
      'user information': 'Informação do usuário',
      'settings restrictions instructions':
          'O acesso à configuração pode ser restrito. Isso é útil se o usuário tentar clicar no ícone de configuração para se distrair do processo de aprendizado. Quando a restrição de configuração está ativada, a resposta para um problema matemático simples deve ser fornecida. Se a resposta estiver correta, o acesso à seção de configuração será concedido. Esse mecanismo de restrição permite que pais e professores restrinjam o acesso à seção de configuração sem a necessidade de lembrar e compartilhar senhas.',
      'settings password protected': 'Restrições de configurações',
      'settings password protected no': 'Sem restrições',
      'settings password protected yes': 'Solicitar resposta matemática',
      'delete linked device': 'Excluir dispositivo vinculado',
      'confirm delete linked device':
          'Deseja excluir o dispositivo vinculado? Se você excluí-lo, precisará vincular novamente mais tarde para adicioná-lo novamente.',
      'echo device': 'Este dispositivo fará eco da caixa de voz',
      'device silent': 'Este dispositivo permanecerá silencioso',
      'device blocked': 'O dispositivo está agora bloqueado.',
      'device unblocked': 'O dispositivo foi desbloqueado.',
      'output voicebox to device':
          'Saída de caixa de voz para outro dispositivo',
      'quizzes': 'Testes',
      'quizzes instructions':
          'Os questionários podem ser criados (como professor / educador) neste dispositivo (os questionários podem ser respondidos em qualquer dispositivo)',
      'can create quiz': 'Pode criar questionário',
      'can not create quiz': 'Não é possível criar um questionário',
      'invite rejected': 'Convite rejeitado por',
      'invite sent': 'Convite enviado para',
      'recieved invite': 'Você recebeu um convite para vincular com',
      'accept': 'Aceitar',
      'ignore and dismiss': 'Ignorar e dispensar',
      'invite confirmed': 'Convite confirmado para',
      'invite accepted': 'Convite aceito por',
      'remember link other party':
          'Lembre-se: repita o mesmo processo no outro dispositivo.',
      'please enter remote email': 'Digite o e-mail da outra parte',
      'add new device': 'Adicionar novo dispositivo',
      'remote user email': 'Email de usuário remoto',
      'remote user email instructions':
          'Para criar um link entre dois dispositivos, verifique se os dois dispositivos estão ligados, conectados à Internet, com o APP em execução e mostrando a tela de dispositivos vinculados (esta tela). O estabelecimento do link deve ser executado nos dois dispositivos (cada dispositivo deve inserir o email da outra parte)',
      'enter remote user email': 'Digite o email do usuário remoto',
      'warning': 'Atenção',
      'email or name not filled':
          'Email ou nome não preenchido. Por favor, preencha essas informações antes de tentar vincular novos dispositivos.',
      'email or name required for backup':
          'Email ou nome não preenchido. Preencha essas informações antes de tentar fazer backup do dispositivo.',
      'email or name required for restore':
          'O e-mail é necessário para restaurar',
      'start restore': 'Iniciar restauração',
      'replace folder': 'Substituir pasta',
      'add to folder': 'Adicionar à pasta',
      'what to do with folder':
          'Selecione a pasta local que será substituída. É sugerido fazer backup deste dispositivo antes de restaurar qualquer pasta, pois o conteúdo da pasta local será excluído antes de substituí-lo pela pasta remota.',
      'choose folder to restore': 'Escolha a pasta para restaurar',
      'quiz': 'Exame',
      'linked devices': 'Dispositivos vinculados',
      'no linked devices': 'Nenhum dispositivo vinculado foi encontrado',
      'change user name': 'Mudar nome de usuário',
      'confirm change user name': 'Deseja alterar o nome do usuário?',
      'user name': 'Nome do usuário',
      'user name hint': 'Digite o nome do usuário',
      'change user email': 'Mude o e-mail',
      'confirm change user email':
          'Se você alterar o email do usuário, precisará vincular novamente os dispositivos (o pai ou o educador precisará recriar o link para este dispositivo). Você quer continuar?',
      'user email': 'Email do usuário',
      'user email instructions':
          'Digite o email a ser usado pelo usuário. Pode ser o email dos pais, se o usuário não tiver um. Não coloque o email do professor ou professor nesse campo. O email é usado para identificar como único cada usuário. O email é usado para vincular dispositivos para sincronização ou questionários.',
      'user email hint': 'Introduzir email',
      'toggle visibility for all':
          'Alterar a visibilidade de todos os conceitos',
      'item availability': 'Disponibilidade do item',
      'item availability instructions':
          'Se um item não estiver disponível, você poderá indicá-lo. Os itens não disponíveis serão mostrados com um X vermelho sobre a imagem',
      'is available': 'Está disponível',
      'is not available': 'Não está disponível',
      'not available': 'Não disponível',
      'available': 'Acessível',
      'delete story': 'Excluir história',
      'confirm delete story': 'Tem certeza de que deseja excluir a história?',
      'level not enabled': 'Nível não ativado',
      'not enough data':
          'A gravação preditiva não está ativada porque não foram coletados dados suficientes',
      'image size': 'Tamanho da imagem',
      'text size': 'Tamanho do texto',
      'small': 'Pequeno',
      'medium': 'Médio',
      'large': 'Ampla',
      'select video': 'Selecionar vídeo',
      'selected video': 'Vídeo selecionado:',
      'recording': 'Gravação...',
      'story object instructions':
          'Você pode descartar conceitos passando-os. Nada será excluído. (os conceitos são excluídos apenas no modo de edição)',
      'edit story name': 'Editar nome da história',
      'select this concept': 'Selecione este conceito',
      'no story object instructions': '',
      'add story object': 'Adicionar conceito',
      'story name hint': 'Digite o nome da história',
      'create new story': 'Crie uma nova história',
      'no stories instructions':
          'As histórias permitem que você junte conceitos (imagens, sons e vídeos) para explicar novas idéias. Por exemplo, você pode explicar uma visita ao zoológico que começa tomando banho, vestindo roupas, tomando café da manhã, viajando de carro e vendo os animais.',
      'add story': 'Adicionar história',
      'please confirm': 'Por favor confirme',
      'replace sound confirmation': 'Deseja substituir o áudio existente?',
      'replace': 'Substituir',
      'voiceBoxSize': 'Tamanho da caixa de voz',
      'big': 'Grande',
      'select sound': 'Gravar audio',
      'select sound instructions':
          'Grave o som que você deseja. Este áudio pode ser reproduzido quando o usuário clica na imagem.',
      'delete': 'Excluir',
      'delete confirmation':
          'Por favor, confirme que você deseja excluir este objeto. Esta operação é irreversível.',
      'warning not user created':
          'AVISO: Este objeto é empacotado por padrão com o APP. Se você excluí-lo, não há como recuperá-lo e você deve adicioná-lo manualmente com sua imagem e texto em cada idioma.',
      'folder not empty will not delete':
          'A pasta deve estar vazia antes de excluir',
      'local device': 'Dispositivo',
      'library': 'Biblioteca',
      'camara': 'Câmera',
      'folder should talk': 'Diga o nome da pasta',
      'folder should talk instructions':
          'Ative se quiser ouvir o nome da pasta ao clicar nela.',
      'loading images': 'Carregando imagens',
      'loading folders': 'Carregando pastas',
      'loading relations': 'Carregando relações',
      'loading categories': 'Carregando categorias',
      'loading videos': 'Carregando vídeos',
      'loading sounds': 'Carregando sons',
      'allowLongPressInLearningScreen':
          'Permita que um conceito seja pressionado por muito tempo no modo de aprendizado',
      'long press instructions':
          'No modo de aprendizado, se o usuário pressionar por muito tempo um conceito, será exibida uma tela apresentando informações detalhadas da opção selecionada.',
      'Not assigned': 'Não atribuído',
      'nothing unlocked': 'Nada desbloqueado',
      'nothing unlocked instructions':
          'Antes de usar esta grade, você deve selecionar (mostrar / desbloquear) os conceitos que deseja. Bloqueie / desbloqueie os conceitos, mantendo-os pressionados. Lembre-se de que as pastas não são mostradas neste nível.',
      'please unlock':
          'Desbloqueie / torne visível os itens desejados em Configuração, Pastas',
      'default folder': 'Pasta padrão',
      'open folders': 'Abrir pastas',
      'default folder instructions':
          'Para selecionar esta pasta como a pasta padrão, clique no botão',
      'understood': 'Entendido',
      'not understood': 'Não compreendido',
      'is understood': 'O conceito é entendido',
      'is not understood': 'Conceito ainda não entendido',
      'conceptIsUnderstood': 'Compreensão do conceito',
      'conceptIsUnderstoodInstructions':
          'Quando o usuário tiver um conceito claro, marque-o como entendido. Isso ajuda os professores e os pais a se comunicarem. Todos os conceitos entendidos são enquadrados em verde na grade de aprendizado.',
      'object visible': 'O objeto está visível no momento',
      'object not visible': 'O objeto não está visível no momento',
      'visibility': 'Visibilidade',
      'visibility instructions':
          'Mostre ou oculte (desbloqueie / bloqueie) as imagens que você deseja',
      'image to show': 'Imagem a mostrar',
      'text to show': 'Texto a mostrar',
      'text to show instructions':
          'Este é o texto mostrado em cada imagem na grade de aprendizado.',
      'text to show hint': 'Digite o texto para mostrar',
      'text to say': 'Texto a dizer',
      'text to say instructions':
          'Você pode mudar o que dizer! Em vez de dizer "Meu nome é ...", você pode alterá-lo para "Meu nome é [coloque o nome aqui]" ou "Minha irmã é [nome da irmã]". Também é útil ter um texto curto para exibir, mas um texto longo para dizer, como quando uma imagem representa uma frase longa.',
      'text to say hint': 'Digite o texto para dizer',
      'edit': 'Editar',
      'no default folder': 'Pasta padrão não selecionada',
      'please select a default folder':
          'Selecione uma pasta padrão. Somente as imagens que você desbloqueou dessa pasta serão exibidas.',
      'select folder': 'Selecionar pasta padrão',
      'select a folder': 'Selecione a pasta remota que deseja importar',
      'current default folder': 'Pasta padrão atual:',
      'unlock': 'Desbloquear',
      'lock': 'Bloquear',
      'debug mode': 'Modo de depuração',
      'user profile': 'Configurações do Usuário',
      'add': 'Adicionar',
      'Grid size': 'Tamanho da grade',
      'grid size instructions':
          'Se desejar, você pode alterar o tamanho da grade (colunas e linhas). Altere essa configuração apenas se você tiver um dispositivo com uma tela grande. Verifique se o usuário pode ver e tocar em cada ícone confortavelmente.',
      'operation completed successfully': 'Operação concluída com sucessoy',
      'restore device': 'Restaurar dispositivo',
      'user email to restore': 'E-mail do usuário para restaurar',
      'categories': 'Categorias',
      'category': 'Categoria',
      'close': 'Fechar',
      'add folder': 'Adicionar pasta',
      'add image': 'Adicionar imagem',
      'add empty': 'Adicione um espaço vazio',
      'add video': 'Adicionar vídeo',
      'add sound': 'Adicionar som',
      'new folder name': '',
      'new image name': '',
      'new video name': '',
      'new sound name': '',
      'show folder': 'Mostrar pasta',
      'hide folder': 'Ocultar pasta',
      'delete folder': 'Excluir pasta',
      'folder instructions':
          'Clique ou clique duas vezes em uma imagem ou em um espaço vazio para ativar suas opções. Clique no menu para explorar mais opções.',
      'grid instructions':
          'Dependendo das necessidades do usuário (para ícones maiores) ou do tamanho da tela do dispositivo, você pode alterar o tamanho da grade das imagens mostradas a partir do nível 5.',
      'grid': 'Grade',
      'Columns': 'Colunas',
      'Rows': 'Linhas',
      'folders': 'Pastas',
      'level not found': 'Nível não encontrado',
      'missing reinforcer': 'Reforço ausente',
      'confirm reinforcer': 'Por favor, confirme que você deseja usar ',
      'selected reinforcer': 'Seu reforçador selecionado atual é:',
      'please select a reinforcer':
          'Por favor, selecione um reforço para este nível',
      'cancel': 'Cancelar',
      'learn': 'Aprender',
      'stories': 'Histórias',
      'schedule': 'Cronograma',
      'help videos': 'Vídeos de ajuda',
      'images': 'Imagens',
      'colors': 'Cores',
      'amber': 'Âmbar',
      'blue': 'Azul',
      'cyan': 'Ciano',
      'deepOrange': 'Laranja profundo',
      'deepPurple': 'Roxo profundo',
      'green': 'Verde',
      'indigo': 'Índigo',
      'lightBlue': 'Azul claro',
      'lightGreen': 'Luz verde',
      'lime': 'Lima',
      'orange': 'Laranja',
      'pink': 'Rosa',
      'purple': 'Roxa',
      'red': 'Vermelho',
      'teal': 'Cerceta',
      'yellow': 'Amarelo',
      'dark mode': 'Modo escuro',
      'select this theme': 'Selecione este tema',
      'select voice': 'Selecionar voz',
      'no voice selected':
          'Nenhuma voz selecionada. Se você não selecionar uma voz, o APP não poderá dizer nenhuma palavra.',
      'tts': 'Texto para fala',
      'voice speed': 'Velocidade de voz',
      'say': 'Diga em voz alta',
      'send by email': 'Enviar por email',
      'user name not configured': 'Nome de usuário não configurado',
      'change': 'mudança',
      'no valid voice found': 'Nenhuma voz válida foi encontrada',
      'test voice': 'Teste a voz. Clique para ativar.',
      'test text':
          'Se você consegue ouvir essa frase, configurou a voz corretamente.',
      'settings title': 'Configuração',
      'levels': 'Níveis',
      'language': 'Língua',
      'select language instructions': 'Selecione seu idioma preferido',
      'Chinese': 'Chinês',
      'English': 'Inglês',
      'Hindi': 'Hindi',
      'Spanish': 'Espanhol',
      'Arabic': 'Árabe',
      'Malay': 'Malaio',
      'Russian': 'Russo',
      'Bengali': 'Bengali',
      'Portuguese': 'Português',
      'French': 'Francês',
      'German': 'Alemão',
      'find image': 'Localizar imagem',
      'selected level': 'Nível selecionado',
      'level1': 'Nível 1',
      'level2': 'Nível 2',
      'level3': 'Nível 3',
      'level4': 'Nível 4',
      'level5': 'Nível 5',
      'level6': 'Nível 6',
      'level7': 'Nível 7',
      'level8': 'Nível 8',
      'level9': 'Nível 9',
      'level10': 'Nível 10',
      'level11': 'Nível 11',
      'change level': 'Alterar nível',
      'summary': 'Sumário',
      'level1 name': 'Reforçador',
      'level1 summary':
          'A principal função desse nível é motivar o usuário a tocar na tela. O resultado do aprendizado é alcançado quando o usuário toca na tela independentemente para solicitar um objeto.',
      'Who does this level cater for': 'Para quem esse nível atende?',
      'level1 Who does this level cater for':
          'Uma criança ou adulto com comunicação limitada a zero. A principal função desse nível é incentivar o usuário a ser motivado pelo aplicativo / dispositivo',
      'How do we achieve this?': 'Como alcançamos isso?',
      'level1 How do we achieve this':
          'Os pais / professor / especialista devem estar cientes do reforço da criança. Um reforçador é um objeto ou item com o qual o usuário desfruta ou é obcecado. Um bom exemplo disso seria um item de comida, como chocolate.',
      'select reinforcer': 'Selecione reforçador',
      'How do we get the user to touch the screen?':
          'Como fazemos o usuário tocar na tela?',
      'level1 How do we get the user to touch the screen':
          'O nível 1 é configurado como uma tela / botão que fala assim que é tocada. Usando o exemplo de chocolate, um pai / professor / especialista deve configurar o aplicativo para mostrar a imagem do chocolate. Os pais / professores / especialistas DEVEM estar preparados durante cada sessão de ensino com muitos pedacinhos de chocolate que podem oferecer uma recompensa instantânea ao usuário. Lembre-se, é importante reservar um tempo para as sessões de ensino, mas todos os momentos do dia podem ser uma oportunidade de ensino. Coloque o iPad em um local onde o usuário possa ter todas as oportunidades de usá-lo. \n\nDurante sua sessão de ensino \n1. Ofereça um pequeno pedaço de chocolate ao usuário. É melhor ter o usuário sentado, embora isso nem sempre seja possível. \n2. Use "entregar mão" para incentivar o usuário a tocar na tela. "Mão sobre mão" é uma abordagem de ensino usada com crianças autistas. O pai / professor / especialista ajuda o usuário, incentivando-o a pressionar o botão. Os pais / professores / especialistas colocam a mão sobre a mão do Usuário e os direcionam para o botão selecionado. * \n3. Assim que o aplicativo falar, o pai / professor / especialista deve dar instantaneamente o chocolate ao usuário. \n4. Isso deve ser repetido regularmente por um período de até 5 minutos, a menos que o usuário fique frustrado. Não forneça chocolate ao usuário até que o botão tenha sido pressionado, independentemente de sua frustração. \n5. Se o usuário ficar frustrado, não desista. Este é um processo longo, mas os ganhos a longo prazo definirão o Usuário para a vida toda. Interrompa e revise esta tarefa quando o usuário estiver calmo. \n\nRepita as etapas de 1 a 5 em intervalos regulares ao longo do dia. Muitos usuários serão muito rápidos em obter sucesso nesse nível e outros exigirão muito trabalho, paciência e esforço. \n\n* A força dessa assistência deve ser gradualmente reduzida. Pode levar meses para remover completamente.',
      'How do you know ready for level 2':
          'Como você sabe que o usuário está pronto para o nível 2?',
      'level1 How do you know ready for level 2':
          'O usuário reduzirá a necessidade de "entrega em mão" quando você perceber que seu filho começa a entender este aplicativo, ajudando-o a obter o reforço. Quando o usuário está pressionando o botão de forma independente e consistente, sem nenhum apoio dos pais / professores, o usuário está pronto para o nível 2',
      'level2 name': 'Escolhas',
      'level2 summary':
          'Este nível foi projetado para ensinar ao usuário que há mais de uma opção para um resultado gratificante. \n\nResultado do aprendizado: o usuário poderá solicitar os dois itens de maneira consistente e com entendimento.',
      'level2 Who does this level cater for':
          'Esse nível é adequado para usuários que acessaram o nível 1 e têm uma necessidade mínima de "entregar mão". O usuário progride ao oferecer duas opções que os incentivam a fazer uma escolha.',
      'level2 How do we achieve this':
          'O pai / professor / especialista deve garantir que a segunda imagem adicionada à tela seja um segundo reforço, por exemplo, suco. \n\nO usuário agora terá a opção de solicitar dois de seus itens favoritos e isso criará um relacionamento com o aplicativo.',
      'select second reinforcer': 'Selecione o segundo reforçador',
      'level2 How do we get the user to touch the screen':
          'Os pais / professores / especialistas usarão as mesmas estratégias empregadas no Nível 1. Em resumo, os dois itens devem estar prontamente disponíveis e fornecidos ao Usuário assim que solicitado. \n\nÉ importante garantir que o usuário esteja recebendo o item correto e esteja ciente da diferença nas duas imagens. O usuário deve receber um dos itens e deve solicitá-lo com precisão e consistência. Os dados estarão disponíveis para destacar respostas e mostrar precisão. \n\nEste nível é um dos níveis mais rápidos para progredir, pois o usuário já deve estar motivado pelo reforço de nível 1.',
      'How do you know ready for level 3':
          'Como você sabe que o usuário está pronto para o nível 3?',
      'level2 How do you know ready for level 3':
          'O usuário demonstrará maior confiança no uso do aplicativo de forma independente e deve haver uma necessidade limitada de "entrega em mão". \n\nQuando o usuário aperta os botões de forma independente e consistente, com suporte limitado dos pais / professor / especialista, isso é um sinal de que o usuário está pronto para o nível 3.',
      'level3 name': 'Más escolhas',
      'level3 summary':
          'Nesta fase, o usuário entenderá que o aplicativo fornece um resultado que lhe agrada. É importante que esse nível seja fornecido, pois essa progressão ensina ao usuário que todas as opções não são gratificantes, mas são comunicação. Este nível é alcançado em um curto período de tempo. \n\nResultado do aprendizado: o usuário deve mostrar aversão ao receber a opção não preferida. O usuário não escolherá mais esta opção.',
      'level3 Who does this level cater for':
          'Esse nível atende a usuários que acessaram os níveis 1 e 2 e têm necessidade mínima / zero de \'entrega\'. O usuário progride ao oferecer uma terceira opção que não é uma escolha favorável.',
      'level3 How do we achieve this':
          'Nesse estágio de desenvolvimento, o usuário agora terá uma opção não preferida. O pai / professor / especialista deve garantir que a terceira imagem adicionada à tela seja um item não preferido, por exemplo, uma meia. \n\nO usuário agora terá a opção de solicitar duas opções preferidas e uma opção não preferida.',
      'select third reinforcer': 'Selecionar terceira palavra',
      'level3 How do we get the user to touch the screen':
          'O usuário agora deve estar motivado pelo aplicativo e ficará intrigado ao tocar nas imagens. Eles receberam prazer das imagens até o momento. O usuário será inquisitivo e deseja receber um resultado positivo do item não preferido. Ele / ela deve ser motivado sem estímulo dos pais / professor / especialista; no entanto, se esse não for o caso, os pais / professores / especialistas devem seguir estratégias do Nível 1 para incentivar essa interação. \n\nSe o Usuário selecionar / tocar qualquer uma das três imagens, eles receberão o item instantaneamente. Os três primeiros níveis foram projetados para ensinar ao usuário como solicitar um item. Esse nível consolida o fato de que nem todas as opções são agradáveis, são solicitações. O usuário agora aprenderá a considerar que as imagens que tocam serão itens que receberão, independentemente de gostarem ou não.',
      'How do you know ready for level 4':
          'Como você sabe que o usuário está pronto para o nível 4?',
      'level3 How do you know ready for level 4':
          'O usuário ficará desapontado ao receber o item não preferido e continuará satisfeito com os outros itens solicitados. Os pais / professor / especialista devem continuar a observar uma maior confiança no uso do aplicativo de forma independente. \n\nQuando o usuário aperta os botões de forma independente e consistente, sem o apoio de pais / professores / especialistas, o usuário está pronto para o nível 4. Os dados provarão essas observações. O usuário também deve observar aversão ao receber a opção não preferida. O usuário não escolherá mais esta opção.',
      'level4 name': 'Caixa de voz',
      'level4 summary':
          'Este nível foi projetado para começar a construir a estrutura de linguagem que será usada nos próximos níveis. A recompensa para o usuário só será dada quando ele / ela selecionar a imagem e tocar na caixa de voz. \n\nResultado da aprendizagem: o usuário selecionará um item escolhido e entenderá que o item não será fornecido até que ele / ele toca na caixa de voz.',
      'level4 Who does this level cater for':
          'Esse nível é adequado para usuários que acessaram os níveis 1 a 3 e agora estão usando o aplicativo de forma independente, com suporte mínimo / zero de "mão sobre mão". \n\nEste nível é um dos níveis mais desafiadores para os pais / professores / especialistas e frustrantes para o usuário. O objetivo deste nível é ensinar o usuário a usar uma caixa de voz que permita o desenvolvimento da linguagem. Nesta fase, o pai / professor / especialista está planejando desenvolver a linguagem preparando o Usuário para usar o nível de duas palavras, ie. quer chocolate. Este nível leva tempo e paciência. Pode ser necessário voltar a "entregar sobre mão" por um curto período de tempo.',
      'level4 How do we achieve this':
          'Nesse estágio, a tela de nível 3 permanece com as mesmas três opções, embora a tela agora tenha uma longa faixa na parte superior da tela. Essa faixa é chamada de "caixa de voz". Quando o usuário tocar nas imagens habituais, a palavra não será mais falada imediatamente. Agora ele será exibido na caixa de voz na parte superior da tela. O usuário agora deve tocar na caixa de voz para permitir que as palavras selecionadas sejam ditas.',
      'level4 How do we get the user to touch the screen':
          'O usuário não receberá mais gratificação instantânea quando o item for solicitado. Ela / ele deve ser incentivado a tocar na caixa de voz. Isso exigirá \'entrega\' para ensinar inicialmente o Usuário e mostrar o que é esperado. Todos os usuários aprenderão isso a uma taxa diferente. Os pais / professor / especialista devem reduzir gradualmente a "mão em mão", dependendo da compreensão do Usuário.',
      'How do you know ready for level 5':
          'Como você sabe que o usuário está pronto para o nível 5?',
      'level4 How do you know ready for level 5':
          'O usuário selecionará o item de forma independente ou, com o suporte da \'mão na mão\', e tocará na caixa de voz. Os dados mostrarão uma alta taxa de sucesso percentual.',
      'level5 name': 'Construindo vocabulário',
      'level 5 folders': 'Comportamento de pastas',
      'level 5 folder info':
          'Pastas não são mostradas neste nível. Isso é intencional, para que o usuário não navegue em outras pastas e desvie o objetivo do nível',
      'level5 summary':
          'Este nível é o início do processo de ensino, com o objetivo principal de criar um idioma para o Usuário. \n\nResultado do aprendizado: O Usuário terá um entendimento claro de 6 ou mais palavras em uma pasta.',
      'level5 Who does this level cater for':
          'This level caters for Users who have accessed Levels 1-4. Users will generally be using the App independently at this stage although some may require ‘hand over hand’ support. \n\nThis level is the start of the teaching process with the primary aim being to build language for the User. The parent/teacher/specialist role becomes more important at this stage as new words should now be introduced to the User, and the parent/teacher/specialist must select words that would be important to the User. The words must also be within the same category ie. using the example of chocolate would require building language for snack items, and the snack items must be those preferred by the User. The categories have been pre-arranged into folders and the words can be made visible as required. If the words/items are not currently available on the folder, the parent/teacher/specialist can take a photo and add them in.\n\nAt this stage, the parent/teacher/specialist must follow the guidance that is provided in the teaching section regarding the use of videos, cards and items. This level takes time and a lot of patience. ‘Hand over hand’ may continue until the User builds his/her confidence.',
      'level5 How do we achieve this':
          'The Parent/Teacher/Specialist section within the App provides detail on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. \n\nThis section includes:\n1.	Continuing to request items\n2.	Matching pictures\n3.	Matching picture to object\n4.	Matching picture to item',
      'level5 How do we get the user to touch the screen':
          'This level requires the User to focus and remain seated to improve communication and build vocabulary. It is unlikely that the User will be willing to engage and therefore it is essential that the main reinforcer is re-introduced. The main reinforcer discussed as an example in the previous summaries was chocolate. In this case the chocolate must be readily available throughout these sessions as the User will be motivated to work if they are provided with a reward. \n\nInitially, the User should be rewarded with their reinforcer after EVERY successful item has been requested ie. when matching every item, the User should be rewarded with a small treat such as a third of a chocolate button. Gradually reduce the reinforcer treat as the User becomes more confident. In time, the User will no longer require a reinforcer. \n\For many this may require ‘hand over hand’ to initially teach the User and show what is expected. All Users will learn this at a different rate. The parent/teacher/specialist should gradually reduce the ‘hand over hand’ depending on the understanding of the User.',
      'How do you know ready for level 6':
          'How do you know the user is ready for level 6?',
      'level5 How do you know ready for level 6':
          'The User will have developed words within this category ie. snacks. This category will continue to be known as the ‘snack’ folder. When a folder contains 6 or more items the User is ready to progress to Level 6. The User would be expected to select items independently although some Users may still prefer ‘hand over hand’ support at this time. Data will continue to be available to show a high percentage success rate in identifying the chosen items. ',
      'level6 name': 'Creating folders',
      'level6 summary':
          'This Level allows Users to develop their language by increasing folders. Folders are created to allow Users to compartmentalize different topics ie. food, transport, clothes. \n\nLearning outcome: The User will show confidence in selecting items. They will be able to move between a minimum of three folders with ease.',
      'level6 Who does this level cater for':
          'This level differs from the others in that it caters for two groups:\n1.	Users who have accessed levels 1-5. These Users will be developing in confidence and most will be using the App independently. Some Users may still require extra support with ‘hand over hand’. Do not discourage this as all Users will develop at a different rate – as confidence grows, the need for support will reduce. \n2.	This would be the suggested stage to introduce the App to Users with limited/zero communication who are visual learners with moderate to good understanding. The parent/teacher/specialist should familiarize themselves with the teaching strategies employed in Levels 1-5 to promote maximum progress and understanding.\n\nThis Level allows Users to develop their language by increasing folders. Folders are created to allow Users to compartmentalize different topics ie. food, transport, clothes. \n\nThe Users who have accessed Levels 1-5 should be engaged and have a clear understanding of what is expected of them. This level allows the parent/teacher/specialist to add different folders to increase the language/speech opportunities. Consider this level as being similar language development for any individual learning a new language. Typical language development starts with one word ie. juice, cat, car. The words come from different folders. We, at Lucas Education, have created a template of folders that we believe are essential for day-to-day communication.',
      'level6 How do we achieve this':
          'One additional folder will be made available to the existing folder in Level 5. For new Users, two folders will be available. The parent/teacher/specialist selects a second folder which contains items that are motivating to the User. When data shows that the User has clearly understood 5 words, the App with allow the opportunity to unlock 5 more words within this folder as well as another folder. \n\nThis process will continue as your User continues to develop and grow. This is a natural process and the same process that all individuals go through when learning to speak and communicate. Level 6 is on-going learning and development.   \n\nThe Parent/Teacher/Specialist section within the App provides further detail on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. Games will be available in due course.\n\nThis section includes:\n1.	Continuing to request items\n2.	Matching pictures\n3.	Matching picture to object\n4.	Matching picture to item',
      'level6 How do we get the user to touch the screen':
          'This Level continues to require the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the program on the move. Examples of such opportunities are when seated in the car or maybe your child enjoys sitting in their pram.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be motivated to work if they are provided with a reward. It is important however to reduce the frequency of the reward. As the language develops, the reinforcer should be reduced and removed.  \n\nThis may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication.',
      'How do you know ready for level 7':
          'How do you know the user is ready for level 7?',
      'level6 How do you know ready for level 7':
          'The User will show confidence in selecting items. They will be able to move between a minimum of three folders with ease. Data will continue to be available to show a high percentage success rate in identifying the chosen items.',
      'level7 name': 'Sentence structure – part one',
      'level7 summary':
          'This Level allows Users to develop sentence structure by introducing a sentence starter. Folders are predesigned to predict possible sentence starters for each folder. \n\nLearning outcome: The User will show confidence in selecting the sentence starter followed by the chosen item. The words will be activated by pressing the voicebox.',
      'level7 Who does this level cater for':
          'This level caters for Users who have accessed Level 6.\n\nThis Level allows Users to develop sentence structure by introducing a sentence starter. Folders are predesigned to predict possible sentence starters for each folder. The option is also available to personalise words.',
      'level7 How do we achieve this':
          'In the previous section, typical language development was discussed. This section takes language development to the next level. Children move from one word level to two. We, at Lucas Education achieve this by introducing sentence starters which vary depending on the folder. Examples of this would be as follows:\n1.	Food folder – I want chocolate……I do not want chocolate.\n2.	Animal folder – I hear cat\n3.	Transport folder – I see car.\n\nSimilar to Level 4, the User may become frustrated during the initial stages of this Level as they are now expected to include a word prior to what has been expected of them in previous levels. For many reinforcers must be introduced again to ensure that the User remains motivated. \n\nAs with the previous folder the words/images will be released when data proves that the User is capable of understanding and consistently includes the sentence starter before requests. Level 7 is on-going learning and development.   \n\nThe Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources.',
      'level7 How do we get the user to touch the screen':
          'This Level also requires the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the programme on the move. Examples of such opportunities are when seated in the car or maybe your child enjoys sitting in their pram.\n\nOnce both icons, namely the sentence starter and the requested item, are appearing in the voice box, the User must touch the voice box and the App will say the sentence for example “I want chocolate” At this point the parent/teacher will give the User what he/she is requesting. The voice box should not be activated until an action and an image are added. Both icons must be spoken in the one voice box; they cannot be selected and spoken independently.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be more motivated to work if they are provided with a reward. This may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication. ',
      'How do you know ready for level 8':
          'How do you know the user is ready for level 8?',
      'level7 How do you know ready for level 8':
          'The User will show confidence in selecting the sentence starter followed by the chosen item. Data will continue to be available to show a high percentage success rate in identifying the chosen items and more sentence starters will be unlocked to develop language further.',
      'level8 name': 'Sentence structure – part two',
      'level8 summary':
          'This level caters for Users who have accessed Level 7.\n\nThis Level allows Users to develop sentence structure by including a sentence closer. Folders are predesigned to predict possible sentence closers for each folder. The option is also available to personalise words.',
      'level8 Who does this level cater for':
          'This level caters for Users who have accessed Level 7.\n\nThis Level allows Users to develop sentence structure by including a sentence closer. Folders are predesigned to predict possible sentence closers for each folder. The option is also available to personalise words.',
      'level8 How do we achieve this':
          'In Level 5, typical language development was promoted and in Level 6 the sentence starters were added. This Level progresses language development to the next level by closing the sentences. We, at Lucas Education achieve this by providing predicted sentence closers which vary depending on the folder. Examples of this would be as follows:\n1.	Food folder – I want chocolate please\n2.	Animal folder – I hear cat\n3.	Transport folder – I see car.\n\nThe final part of the sentences can or cannot be used in conjunction with the action and objects. For example in some cases, the closing part can be used alone eg. All done!\n\nSimilar to Levels 4 and 7, the User may become a little frustrated during the initial stages of this Level as they are now expected to include a word following what has been expected of them in previous levels. For many, reinforcers must be introduced again to ensure that the User remains motivated. \n\nAs with the previous folder the words/images will be released when data proves that the User is capable of understanding and consistently includes the sentence closer after requests. Level 8 is on-going learning and development.\n\The Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. ',
      'level8 How do we get the user to touch the screen':
          'This Level also requires the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the programme on the move. Such opportunities could be made possible at snack time or perhaps when ordering food at a takeaway.\n\nWhen all three icons, namely the sentence starter, the requested item and the sentence closer, are appearing in the voice box, the User must touch the voice box and the App will say the sentence, for example “I want chocolate, please!”. At this point the parent/teacher will give the person what she/he is requesting. The voice box should not be activated until an action, an image and a closer are added. All three icons must be spoken in the one voice box; they cannot be selected and spoken independently.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be more motivated to work if they are provided with a reward. This may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication.',
      'How do you know ready for level 9':
          'How do you know the user is ready for level 9?',
      'level8 How do you know ready for level 9':
          'The User will show confidence in selecting the sentence starter followed by the chosen item and sentence closer. Data will continue to be available to show a high percentage success rate in identifying the chosen items and more sentence closers will be unlocked to develop language further. \n\nUsers at this Level are now capable of accessing Levels 9, 10 and 11. All three Levels are challenging and cater for higher functioning Users. These Levels do not have to taught in a sequential order, for example, the User may find difficulty in progressing through Levels 9 and 10, but may succeed in Level 11.',
      'level9 name': 'Grammar and developed literacy',
      'level9 summary':
          'This Level allows higher functioning Users the opportunity to focus on building sentence structure by developing literacy through use of conjunctions, connectives and pronouns.\nThis is an important building block to teaching the User how to read. \n\nTHIS IS ONE OF THE MORE CHALLENGING LEVELS.\n\nLearning outcome: The User will have the ability to communicate with confidence by linking words with conjunctives and using other literacy cues to develop language further.',
      'level9 Who does this level cater for':
          'This level caters for Users who have accessed Level 8.\n\nThis Level allows higher functioning Users the opportunity to focus on building sentence structure by developing literacy through use of conjunctions, connectives and pronouns.\n\nTHIS IS ONE OF THE MORE CHALLENGING LEVELS.',
      'level9 How do we achieve this':
          'The Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. \n\nData will also assist in gathering success criteria and in unlocking progressive language.',
      'level9 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program. ',
      'How do you know ready for level 10':
          'How do you know the user is ready for level 10?',
      'level9 How do you know ready for level 10':
          'The User is capable to access Level 10 directly from Level 8. All Levels can be used at the same time to develop language. Words will be unlocked when data dictates that the User is ready. ',
      'level10 name': 'Learning words',
      'level10 summary':
          'This Level allows higher functioning Users the opportunity to focus on learning words as opposed to pictures. This Level progresses by removing pictures and replacing them with the name/text of each object. This is the initial step in providing our non-verbal children with the opportunity to read.\n\nLearning outcome: The User will have the ability to communicate with the same confidence by using words as opposed to images.',
      'level10 Who does this level cater for':
          'This level caters for Users who have accessed Level 8 or 9.\n\nThis Level allows higher functioning Users the opportunity to focus on learning words as opposed to pictures. Users who require images should bypass this Level and access Level 10.',
      'level10 How do we achieve this':
          'The Parent/Teacher/Specialist will have an understanding of the favourite words selected by the User. Data will also assist in gathering such details. All words have been set up to show a large image with a small defined word below (show example). The Parent/Teacher/Specialist will now gradually reduce the size of the picture for the favourite words, whilst increasing the size of the word. With time the Parent/Teacher/Specialist will aim to remove the image and only provide the User with the word. Once again, experience and data will provide feedback on the understanding of the User and their readiness to remove images from other buttons.',
      'level10 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program. If they are unable to use the words when the images have been reduced, this is a sign that the User is not ready for this Level and it must be revisited at another stage.',
      'How do you know ready for level 11':
          'How do you know the user is ready for level 11?',
      'level10 How do you know ready for level 11':
          'The User will show confidence in selecting icons with words as opposed to images. Data will continue to be available to show a high percentage success rate in identifying the chosen items.',
      'level11 name': 'predictive images/writing',
      'level11 summary':
          'This Level allows Users the opportunity to communicate with greater speed by providing the User with the opportunity to select predicted images or words. \n\nLearning outcome: The User will have the ability to communicate with the same confidence although at a greater speed and fluency.',
      'level11 Who does this level cater for':
          'This level caters for Users who have accessed Level 8.\n\nThis Level allows Users the opportunity to communicate with greater speed. ',
      'level11 How do we achieve this':
          'This Level provides the User with the opportunity to select predicted images or words. The App will provide a list of actions to be selected by the user. Once an action is selected, the pictures/words to be shown will be presented depending on the frequency of usage for each word. The most used words will appear higher in the grid while less used words for that specific action will appear lower on the grid.',
      'level11 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program',
    },
    // French (229 million)
    'fr': {
      'app title': 'LUCAS',
      'relation': 'Relation',
      'schedule day': 'Jour de programme',
      'sound': 'Du son',
      'video': 'Vidéo',
      'story object': 'Objet de l\'histoire',
      'translation': 'Traduction',
      'start': 'Démarrer la sauvegarde',
      'backup device': 'Sauvegarder cet appareil',
      'Minimum level to show': 'Niveau minimum à afficher',
      'background color': 'Couleur de l\'arrière plan',
      'loading empty spaces': 'Chargement des espaces vides',
      'loading translations': 'Chargement des traductions',
      'Drag and drop enabled': 'Glisser-déposer activé',
      'Drag and drop disabled': 'Glisser-déposer désactivé',
      'about this app': 'À propos de cette appli',
      'text to find': 'Trouver',
      'text to find instructions': '',
      'number of concepts': 'Nombre de concepts',
      'one concept': 'Un concept',
      'two concepts': 'Deux concepts',
      'three or more': 'Trois concepts ou plus',
      'students': 'Élèves',
      'find results': 'Trouver les résultats',
      'result is correct': 'Le résultat est correct',
      'result is wrong': 'Le résultat est faux',
      'play quiz': 'Écoutez le quiz',
      'silent quiz ongoing': 'Quiz silencieux en cours',
      'send to device': 'Envoyer à:',
      'quiz type': 'Type de quiz',
      'quiz show image': 'Afficher les images',
      'quiz sound image': 'Prononcez les concepts',
      'quiz show sound and image':
          'Prononcez les concepts et montrez des images',
      'quiz do not show anything': 'Ne rien montrer',
      'send quiz': 'Envoyer un quiz',
      'schedule_title1': 'Bienvenue',
      'schedule_title2': 'Moment de la journée',
      'schedule_title3': 'Mode édition',
      'schedule_title4': 'Ajouter un objet',
      'schedule_title5': 'Gérer les jours',
      'schedule_text1':
          'L\'horaire permet de visualiser les choses qui vont se passer. Il permet à votre utilisateur de comprendre ce qu\'il fera aujourd\'hui et à l\'avenir. Vous pouvez appuyer longuement sur un élément pour l\'agrandir.',
      'schedule_text2':
          'Masquer / afficher l\'heure de la journée à laquelle chaque activité aura lieu.',
      'schedule_text3':
          'Le mode édition permet de gérer les concepts. En mode édition, tous les jours seront affichés et vous pouvez cliquer sur chaque objet pour interagir avec lui.',
      'schedule_text4':
          'Sélectionnez le jour / l\'heure et l\'image que vous souhaitez afficher.',
      'schedule_text5': 'Si vous devez ajouter de nouveaux jours, cliquez ici.',
      'existing concept':
          'Il existe déjà un concept pour le même jour et la même heure. Veuillez corriger et réessayer.',
      'please select an object': 'Veuillez sélectionner un objet',
      'please select a day': 'Veuillez sélectionner un jour',
      'select an object': 'Sélectionnez un objet',
      'add object': 'Ajouter un objet à la planification',
      'select day': 'Sélectionnez le jour',
      'selected day': 'Jour sélectionné',
      'select hour': 'Sélectionnez l\'heure',
      'monday': 'Lundi',
      'tuesday': 'Mardi',
      'wednesday': 'Mercredi',
      'thursday': 'Jeudi',
      'friday': 'Vendredi',
      'saturday': 'Samedi',
      'sunday': 'Dimanche',
      'school': 'École',
      'home': 'Accueil',
      'today': 'Aujourd\'hui',
      'tomorrow': 'Demain',
      'no action required title': 'Aucune action n\'est requise',
      'no action required info':
          'Veuillez lire les informations fournies et continuer en cliquant sur l\'icône Learn',
      'reset': 'Réinitialiser',
      'video_title1': 'Vidéo d\'introduction',
      'video_title2': 'Niveau 1',
      'video_title3': 'Niveau 2',
      'video_title4': 'Niveau 3',
      'video_title5': 'Niveau 4',
      'video_title6': 'Niveau 5',
      'video_title7': 'Niveau 6',
      'video_title8': 'Niveau 7',
      'video_title9': 'Niveau 8',
      'video_title10': 'Niveau 9',
      'video_title11': 'Niveau 10',
      'video_title12': 'Niveau 11',
      'video_title13': 'Paramètres utilisateur',
      'video_text1': 'Notre vidéo d\'introduction',
      'video_text2': 'Vidéo de renforcement',
      'video_text3': 'Vidéo sur les choix',
      'video_text4': 'Vidéo Mauvais choix',
      'video_text5': 'Vidéo de boîte vocale',
      'video_text6': 'Vidéo de construction du vocabulaire',
      'video_text7': 'Création de dossiers vidéo',
      'video_text8': 'Structure des phrases - première partie vidéo',
      'video_text9': 'Structure des phrases - deuxième partie vidéo',
      'video_text10': 'Vidéo de grammaire et d\'alphabétisation développée',
      'video_text11': 'Vidéo d\'apprentissage des mots',
      'video_text12': 'Images prédictives / vidéo d\'écriture',
      'video_text13': 'Vidéo sur les paramètres utilisateur',
      'showHelper_LevelSettings_title1': 'Première:',
      'showHelper_LevelSettings_title2': 'Remplissez les informations',
      'showHelper_LevelSettings_title3': 'Changer de niveau',
      'showHelper_LevelSettings_title4': 'Écran d\'apprentissage',
      'showHelper_LevelSettings_text1':
          'Veuillez lire toutes les informations que nous vous avons fournies',
      'showHelper_LevelSettings_text2':
          'Certains niveaux nécessitent des informations de votre part. Ils sont clairement mis en évidence',
      'showHelper_LevelSettings_text3':
          'Si vous devez changer de niveau, veuillez le faire en appuyant sur cette icône',
      'showHelper_LevelSettings_text4':
          'Une fois prêt, revenez à l\'écran Apprendre',
      'showHelper_image-settings_title1': 'Trouver',
      'showHelper_image-settings_title2': 'Éditer',
      'showHelper_image-settings_title3': 'Taille de la grille',
      'showHelper_image-settings_title4': 'Aidez-moi',
      'showHelper_image-settings_text1':
          'Entrez le texte et appuyez sur le bouton pour trouver les images',
      'showHelper_image-settings_text2':
          'Cliquez sur l\'image pour la modifier',
      'showHelper_image-settings_text3':
          'Modifiez la taille de la grille en appuyant sur ce bouton',
      'showHelper_image-settings_text4':
          'Activer ou désactiver l\'aide en utilisant ce bouton',
      'showHelper_folders_title1': 'Cliquez sur',
      'showHelper_folders_title2': 'Double clic',
      'showHelper_folders_title3': 'Appui long',
      'showHelper_folders_title4': 'Ajouter',
      'showHelper_folders_title5': 'Retour au dossier parent',
      'showHelper_folders_text1':
          'Cliquez sur un article pour voir ses propriétés',
      'showHelper_folders_text2':
          'Double-cliquez sur un dossier pour voir ses enfants',
      'showHelper_folders_text3':
          'Appuyez longuement sur un élément pour le verrouiller / déverrouiller',
      'showHelper_folders_text4':
          'Ajouter des dossiers, des images, des sons et des vidéos',
      'showHelper_folders_text5':
          'Pour revenir au dossier parent, appuyez sur cette icône',
      'Show Help Screens': 'Afficher les écrans d\'aide',
      'privacy policy': 'Politique de confidentialité',
      'must accept privacy policy':
          'Vous devez accepter notre politique de confidentialité avant de continuer',
      'view privacy policy': 'Voir la politique de confidentialité',
      'accept privacy policy': 'Accepter la politique de confidentialité',
      'show hide schedule': 'Afficher / masquer le calendrier',
      'show hide stories and schedule':
          'Afficher ou masquer les histoires et le calendrier',
      'show': 'Spectacle',
      'hide': 'Cacher',
      'share item': 'Partager',
      'check connection': 'Vérifier la connexion',
      'not connected to internet':
          'On dirait que vous n\'êtes pas connecté à Internet',
      'user information': 'Informations de l\'utilisateur',
      'settings restrictions instructions':
          'L\'accès à la configuration peut être restreint. Ceci est utile si l\'utilisateur essaie de cliquer sur l\'icône de configuration pour se distraire du processus d\'apprentissage. Lorsque la restriction de configuration est activée, la réponse à un problème mathématique simple doit être fournie. Si la réponse est correcte, l\'accès à la section de configuration sera accordé. Ce mécanisme de restriction permet aux parents et aux enseignants de restreindre l\'accès à la section de configuration sans avoir à mémoriser et à partager des mots de passe.',
      'settings password protected': 'Restrictions des paramètres',
      'settings password protected no': 'Pas de restrictions',
      'settings password protected yes': 'Demander une réponse mathématique',
      'delete linked device': 'Supprimer l\'appareil lié',
      'confirm delete linked device':
          'Voulez-vous supprimer le périphérique lié? Si vous le supprimez, vous devrez le reconnecter ultérieurement pour le rajouter.',
      'echo device': 'Cet appareil fera écho à la boîte vocale',
      'device silent': 'Cet appareil restera silencieux',
      'device blocked': 'L\'appareil est maintenant bloqué.',
      'device unblocked': 'L\'appareil a été débloqué.',
      'output voicebox to device':
          'Sortie de la boîte vocale sur un autre appareil',
      'quizzes': 'Quiz',
      'quizzes instructions':
          'Les questionnaires peuvent être créés (en tant que professeur / éducateur) sur cet appareil (les questionnaires peuvent être répondus sur n\'importe quel appareil)',
      'can create quiz': 'Peut créer un quiz',
      'can not create quiz': 'Impossible de créer un quiz',
      'invite rejected': 'Invitation rejetée par',
      'invite sent': 'Invitation Envoyée à',
      'recieved invite': 'Vous avez reçu une invitation à créer un lien avec',
      'accept': 'J\'accepte',
      'ignore and dismiss': 'Ignorer',
      'invite confirmed': 'Invitation confirmée à',
      'invite accepted': 'Invitation acceptée par',
      'remember link other party':
          'N\'oubliez pas: répétez le même processus sur l\'autre appareil.',
      'please enter remote email':
          'Veuillez saisir l\'e-mail de l\'autre partie',
      'add new device': 'Ajouter un nouvel appareil',
      'remote user email': 'Courriel de l\'utilisateur distant',
      'remote user email instructions':
          'Pour créer un lien entre deux appareils, assurez-vous que les deux appareils sont allumés, connectés à Internet, que l\'application fonctionne et affichent l\'écran des appareils liés (cet écran). L\'établissement du lien doit être exécuté sur les deux appareils (chaque appareil doit entrer le courrier électronique de l\'autre partie)',
      'enter remote user email':
          'Saisissez l\'adresse e-mail de l\'utilisateur distant',
      'warning': 'Avertissement',
      'email or name not filled':
          'Courriel ou nom non renseigné. Veuillez compléter ces informations avant d\'essayer de lier de nouveaux appareils.',
      'email or name required for backup':
          'Email ou nom non renseigné. Veuillez compléter ces informations avant d\'essayer de sauvegarder l\'appareil.',
      'email or name required for restore':
          'Un e-mail est requis pour restaurer',
      'start restore': 'Démarrer la restauration',
      'replace folder': 'Remplacer le dossier',
      'add to folder': 'Ajouter au dossier',
      'what to do with folder':
          'Sélectionnez le dossier local qui sera remplacé. Il est suggéré de sauvegarder cet appareil avant de restaurer un dossier car le contenu du dossier local sera supprimé avant de le remplacer par le dossier distant.',
      'choose folder to restore': 'Choisissez le dossier à restaurer',
      'quiz': 'Examen',
      'linked devices': 'Appareils liés',
      'no linked devices': 'Aucun appareil lié trouvé',
      'change user name': 'Changer le nom d\'utilisateur',
      'confirm change user name':
          'Voulez-vous changer le nom de l\'utilisateur?',
      'user name': 'Nom d\'utilisateur',
      'user name hint': 'Entrez le nom de l\'utilisateur',
      'change user email': 'Changer l\'e-mail',
      'confirm change user email':
          'Si vous modifiez l\'e-mail de l\'utilisateur, vous devrez relier les appareils (le parent ou l\'éducateur devra recréer le lien vers cet appareil). Voulez-vous continuer?',
      'user email': 'E-mail de l\'utilisateur',
      'user email instructions':
          'Saisissez l\'e-mail à utiliser par l\'utilisateur. Il peut s\'agir de l\'e-mail du parent si l\'utilisateur n\'en a pas. Ne mettez pas l\'e-mail de l\'éducateur ou de l\'enseignant dans ce champ. L\'e-mail est utilisé pour identifier comme unique chaque utilisateur. L\'e-mail est utilisé pour lier des appareils pour la synchronisation ou des quiz.',
      'user email hint': 'Entrez votre e-mail',
      'toggle visibility for all':
          'Modifier la visibilité de tous les concepts',
      'item availability': 'Disponibilité des articles',
      'item availability instructions':
          'Si un article n\'est pas disponible, vous pouvez l\'indiquer. Les éléments non disponibles seront affichés avec un X rouge sur l\'image',
      'is available': 'Est disponible',
      'is not available': 'N\'est pas disponible',
      'not available': 'Indisponible',
      'available': 'Disponible',
      'delete story': 'Supprimer l\'histoire',
      'confirm delete story': 'Voulez-vous vraiment supprimer l\'histoire?',
      'level not enabled': 'Niveau non activé',
      'not enough data':
          'L\'écriture prédictive n\'est pas activée car pas assez de données ont été collectées',
      'image size': 'Taille de l\'image',
      'text size': 'Taille du texte',
      'small': 'Petit',
      'medium': 'Moyen',
      'large': 'Grand',
      'select video': 'Sélectionnez la vidéo',
      'selected video': 'Vidéo sélectionnée:',
      'recording': 'Enregistrement...',
      'story object instructions':
          'Vous pouvez ignorer les concepts en les faisant glisser. Rien ne sera supprimé. (les concepts ne sont supprimés qu\'en mode édition)',
      'edit story name': 'Modifier le nom de l\'histoire',
      'select this concept': 'Sélectionnez ce concept',
      'no story object instructions': '',
      'add story object': 'Ajouter un concept',
      'story name hint': 'Entrez le nom de l\'histoire',
      'create new story': 'Créez une nouvelle histoire',
      'no stories instructions':
          'Les histoires vous permettent de joindre des concepts (images, sons et vidéos) pour expliquer de nouvelles idées. Par exemple, vous pouvez expliquer une visite au zoo qui commence par prendre une douche, mettre des vêtements, prendre le petit déjeuner, voyager en voiture et voir les animaux.',
      'add story': 'Ajouter une histoire',
      'please confirm': 'Veuillez confirmer',
      'replace sound confirmation': 'Voulez-vous remplacer l\'audio existant?',
      'replace': 'Remplacer',
      'voiceBoxSize': 'Taille de la boîte vocale',
      'big': 'Gros',
      'select sound': 'Enregistrement audio',
      'select sound instructions':
          'Enregistrez le son que vous souhaitez. Cet audio peut être lu lorsque l\'utilisateur clique sur l\'image.',
      'delete': 'Supprimer',
      'delete confirmation':
          'Confirmez que vous souhaitez supprimer cet objet. Cette opération est irréversible.',
      'warning not user created':
          'AVERTISSEMENT: cet objet est fourni par défaut avec l\'application. Si vous le supprimez, il n\'y a aucun moyen de le récupérer et vous devez l\'ajouter manuellement avec son image et son texte dans chaque langue.',
      'folder not empty will not delete':
          'Le dossier doit être vide avant la suppression.',
      'local device': 'Dispositif',
      'library': 'Bibliothèque',
      'camara': 'Caméra',
      'folder should talk': 'Dites le nom du dossier',
      'folder should talk instructions':
          'Activez cette option si vous souhaitez entendre le nom du dossier lorsque vous cliquez dessus.',
      'loading images': 'Chargement des images',
      'loading folders': 'Chargement de dossiers',
      'loading relations': 'Chargement des relations',
      'loading categories': 'Chargement des catégories',
      'loading videos': 'Chargement de vidéos',
      'loading sounds': 'Chargement des sons',
      'allowLongPressInLearningScreen':
          'Permet d\'appuyer longtemps sur un concept en mode d\'apprentissage',
      'long press instructions':
          'En mode apprentissage, si l\'utilisateur appuie longuement sur un concept, un écran présentant des informations détaillées sur l\'option sélectionnée s\'affiche.',
      'Not assigned': 'Non attribué',
      'nothing unlocked': 'Rien débloqué',
      'nothing unlocked instructions':
          'Avant d\'utiliser cette grille, vous devez sélectionner (afficher / déverrouiller) les concepts souhaités. Verrouillez / déverrouillez les concepts en les maintenant enfoncés. Rappelez-vous que les dossiers ne sont pas affichés à ce niveau.',
      'please unlock':
          'Veuillez déverrouiller / rendre visibles les éléments souhaités dans Configuration, Dossiers',
      'default folder': 'Dossier par défaut',
      'open folders': 'Dossiers ouverts',
      'default folder instructions':
          'Pour sélectionner ce dossier comme dossier par défaut, cliquez sur le bouton.',
      'understood': 'Compris',
      'not understood': 'Pas compris',
      'is understood': 'Le concept est compris',
      'is not understood': 'Le concept n\'est pas encore compris',
      'conceptIsUnderstood': 'Compréhension du concept',
      'conceptIsUnderstoodInstructions':
          'Une fois que l\'utilisateur a le concept clair, marquez-le comme compris. Cela aide les enseignants et les parents à communiquer. Tous les concepts compris sont encadrés en vert dans la grille d\'apprentissage.',
      'object visible': 'L\'objet est actuellement visible',
      'object not visible': 'L\'objet n\'est actuellement pas visible',
      'visibility': 'Visibilité',
      'visibility instructions':
          'Afficher ou masquer (déverrouiller / verrouiller) les images souhaitées',
      'image to show': 'Image à montrer',
      'text to show': 'Texte à afficher',
      'text to show instructions':
          'Ceci est le texte affiché sous chaque image dans la grille d\'apprentissage.',
      'text to show hint': 'Entrez le texte à afficher',
      'text to say': 'Texte à dire',
      'text to say instructions':
          'Vous pouvez changer quoi dire! Au lieu de dire "Mon nom est ...", vous pouvez le remplacer par "Mon nom est [mettez le nom ici]" ou "Ma soeur est [nom de soeur]". Il est également utile d’afficher un texte court, mais un texte long à dire, par exemple, quand une image représente une phrase longue.',
      'text to say hint': 'Entrez le texte à dire',
      'edit': 'Modifier',
      'no default folder': 'Dossier par défaut non sélectionné',
      'please select a default folder':
          'Sélectionnez un dossier par défaut. Seules les images que vous avez déverrouillées à partir de ce dossier seront affichées.',
      'select folder': 'Sélectionner le dossier par défaut',
      'select a folder':
          'Sélectionnez le dossier distant que vous souhaitez importer',
      'current default folder': 'Dossier par défaut actuel:',
      'unlock': 'Ouvrir',
      'lock': 'Fermer à clé',
      'debug mode': 'Mode débogage',
      'user profile': 'Paramètres utilisateur',
      'add': 'Ajouter',
      'Grid size': 'Taille de la grille',
      'grid size instructions':
          'Si vous le souhaitez, vous pouvez modifier la taille de la grille (colonnes et lignes). Ne modifiez ce paramètre que si vous possédez un appareil avec un grand écran. Vérifiez que l\'utilisateur peut voir et toucher chaque icône confortablement.',
      'operation completed successfully': 'Opération terminée avec succès',
      'restore device': 'Restaurer l\'appareil',
      'user email to restore': 'E-mail de l\'utilisateur à restaurer',
      'categories': 'Catégories',
      'category': 'Catégorie',
      'close': 'Proche',
      'add folder': 'Ajouter le dossier',
      'add image': 'Ajouter une image',
      'add empty': 'Ajouter un espace vide',
      'add video': 'Ajouter une vidéo',
      'add sound': 'Ajouter du son',
      'new folder name': '',
      'new image name': '',
      'new video name': '',
      'new sound name': '',
      'show folder': 'Afficher le dossier',
      'hide folder': 'Masquer le dossier',
      'delete folder': 'Supprimer le dossier',
      'folder instructions':
          'Cliquez ou double-cliquez sur une image ou un espace vide pour activer ses options. Cliquez sur le menu pour explorer plus d\'options.',
      'grid instructions':
          'En fonction des besoins de l\'utilisateur (pour les grandes icônes) ou de la taille de l\'écran de l\'appareil, vous pouvez modifier la taille de la grille des images affichées à partir du niveau 5.',
      'grid': 'La grille',
      'Columns': 'Colonnes',
      'Rows': 'Lignes',
      'folders': 'Dossiers',
      'level not found': 'Niveau non trouvé',
      'missing reinforcer': 'Renfort manquant',
      'confirm reinforcer':
          'S\'il vous plaît confirmer que vous souhaitez utiliser ',
      'selected reinforcer': 'Votre renforçant actuellement sélectionné est:',
      'please select a reinforcer':
          'Veuillez sélectionner un renforçant pour ce niveau',
      'cancel': 'Annuler',
      'learn': 'Apprendre',
      'stories': 'Histoires',
      'schedule': 'Programme',
      'help videos': 'Vidéos d\'aide',
      'images': 'Images',
      'colors': 'Couleurs',
      'amber': 'Ambre',
      'blue': 'Bleu',
      'cyan': 'Cyan',
      'deepOrange': 'Orange profond',
      'deepPurple': 'Violet foncé',
      'green': 'Vert',
      'indigo': 'Indigo',
      'lightBlue': 'Bleu clair',
      'lightGreen': 'Vert clair',
      'lime': 'Citron vert',
      'orange': 'Orange',
      'pink': 'Rose',
      'purple': 'Violet',
      'red': 'Rouge',
      'teal': 'Sarcelle',
      'yellow': 'Jaune',
      'dark mode': 'Mode sombre',
      'select this theme': 'Sélectionnez ce thème',
      'select voice': 'Sélectionnez la voix',
      'no voice selected':
          'Aucune voix sélectionnée. Si vous ne sélectionnez pas de voix, l\'application ne pourra pas dire un mot.',
      'tts': 'Texte à la parole',
      'voice speed': 'Vitesse de la voix',
      'say': 'Dis à haute voix',
      'send by email': 'Envoyé par email',
      'user name not configured': 'Nom d\'utilisateur non configuré',
      'change': 'Changement',
      'no valid voice found': 'Aucune voix valide n\'a été trouvée',
      'test voice': 'Testez la voix. Cliquez pour activer.',
      'test text':
          'Si vous entendez cette phrase, vous avez correctement configuré la voix.',
      'settings title': 'Configuration',
      'levels': 'Les niveaux',
      'language': 'Langage',
      'select language instructions': 'Sélectionnez votre langue préférée',
      'Chinese': 'Chinois',
      'English': 'Anglais',
      'Hindi': 'Hindi',
      'Spanish': 'Espagnol',
      'Arabic': 'Arabe',
      'Malay': 'Malais',
      'Russian': 'Russe',
      'Bengali': 'Bengali',
      'Portuguese': 'Portugais',
      'French': 'Français',
      'German': 'Allemand',
      'find image': 'Trouver une image',
      'selected level': 'Niveau sélectionné',
      'level1': 'Niveau 1',
      'level2': 'Niveau 2',
      'level3': 'Niveau 3',
      'level4': 'Niveau 4',
      'level5': 'Niveau 5',
      'level6': 'Niveau 6',
      'level7': 'Niveau 7',
      'level8': 'Niveau 8',
      'level9': 'Niveau 9',
      'level10': 'Niveau 10',
      'level11': 'Niveau 11',
      'change level': 'Changer de niveau',
      'summary': 'Sommaire',
      'level1 name': 'Renfort',
      'level1 summary':
          'La fonction principale de ce niveau est de motiver l\'utilisateur à toucher l\'écran. Le résultat d\'apprentissage est atteint lorsque l\'utilisateur touche l\'écran indépendamment pour demander un objet.',
      'Who does this level cater for': 'A qui s' 'adresse ce niveau?',
      'level1 Who does this level cater for':
          'Un enfant ou un adulte avec une communication limitée, à zéro. La fonction principale de ce niveau est d’encourager l’utilisateur à être motivé par l’APP / appareil',
      'How do we achieve this?': 'Comment pouvons-nous y parvenir?',
      'level1 How do we achieve this':
          'Le parent / enseignant / spécialiste doit connaître le renforcement de l’enfant. Un renforçateur est un objet ou un objet dont l\'utilisateur jouit ou qui est obsédé. Un bon exemple de ceci serait un produit alimentaire, tel que le chocolat.',
      'select reinforcer': 'Sélectionnez renfort',
      'How do we get the user to touch the screen?':
          'Comment pouvons-nous amener l' 'utilisateur à toucher l' 'écran?',
      'level1 How do we get the user to touch the screen':
          'Le niveau 1 est configuré comme un écran / bouton qui parle dès que vous le touchez. À l\'aide de l\'exemple du chocolat, un parent / enseignant / spécialiste doit configurer l\'application pour afficher l\'image au chocolat. Le parent / enseignant / spécialiste DOIT être préparé lors de chaque session d’enseignement en disposant de nombreux petits morceaux de chocolat pouvant fournir une récompense immédiate à l’utilisateur. N\'oubliez pas qu\'il est important de réserver du temps pour les sessions d\'enseignement, mais chaque moment de la journée peut être une opportunité d\'enseignement. Avoir l\'iPad dans un endroit où l\'utilisateur peut avoir toutes les chances de l\'utiliser. \n\nPendant votre session d’enseignement \n1. Offrez un petit morceau de chocolat à l\'utilisateur. Il est préférable que l\'utilisateur soit assis, bien que cela ne soit pas toujours possible. \n2. Utilisez ‘main sur main’ pour encourager l’utilisateur à toucher l’écran. La «main sur la main» est une approche pédagogique utilisée avec des enfants autistes. Le parent / enseignant / spécialiste assiste l\'utilisateur en l\'encourageant à appuyer sur le bouton. Le parent / enseignant / spécialiste place la main sur celle de l’utilisateur et le dirige vers le bouton sélectionné. * \n3. Dès que l\'application parle, le parent / enseignant / spécialiste doit immédiatement donner le chocolat à l\'utilisateur. \n4. Cela doit être répété régulièrement pendant une période allant jusqu\'à 5 minutes, à moins que l\'utilisateur ne soit frustré. Ne fournissez pas de chocolat à l’utilisateur jusqu’à ce que vous appuyiez sur le bouton, quelle que soit leur frustration. \n5. Si l\'utilisateur devient frustré, n\'abandonnez pas. Le processus est long, mais les gains à long terme permettront à l\'utilisateur de se préparer à la vie. Arrêtez et revenez sur cette tâche lorsque l\'utilisateur est calme. \n\nRépétez les étapes 1 à 5 à intervalles réguliers tout au long de la journée. De nombreux utilisateurs seront très rapides à réussir à ce niveau et d’autres prendront beaucoup de travail, de patience et d’efforts. \n\n * La force de cette assistance devrait être progressivement réduite. Cela peut prendre des mois pour éliminer complètement.',
      'How do you know ready for level 2':
          'Comment savez-vous que l' 'utilisateur est prêt pour le niveau 2?',
      'level1 How do you know ready for level 2':
          'L\'utilisateur réduira le besoin de "main sur main" lorsque vous remarquerez que votre enfant commence à comprendre que cette application les aide à obtenir leur renforçateur. Lorsque l\'utilisateur appuie sur le bouton de manière indépendante et cohérente, sans aucun soutien du parent / de l\'enseignant, l\'utilisateur est prêt pour le niveau 2',
      'level2 name': 'Les choix',
      'level2 summary':
          'Ce niveau est conçu pour apprendre à l\'utilisateur qu\'il existe plus d\'une option pour obtenir un résultat gratifiant. \n\n Résultat d\'apprentissage: l\'utilisateur aura la possibilité de demander les deux éléments de manière cohérente et compréhensive.',
      'level2 Who does this level cater for':
          'Ce niveau s’adresse aux utilisateurs qui ont accédé au niveau 1 et qui ont un besoin minimal de «passer le relais». L\'utilisateur progresse en se voyant proposer deux options qui l\'encouragent à faire un choix.',
      'level2 How do we achieve this':
          'Le parent / enseignant / spécialiste doit s\'assurer que la deuxième image ajoutée à l\'écran est un deuxième renforçateur, par exemple, du jus. \n\nL\'utilisateur aura désormais la possibilité de demander deux de ses éléments favoris, ce qui renforcera sa relation avec l\'application.',
      'select second reinforcer': 'Sélectionnez le deuxième renforçant',
      'level2 How do we get the user to touch the screen':
          'Le parent / enseignant / spécialiste utilisera les mêmes stratégies que celles utilisées au niveau 1. En résumé, les deux éléments doivent être facilement disponibles et fournis à l\'utilisateur dès que demandé. \n\nIl est important de s’assurer que l’utilisateur obtient le bon article et est conscient de la différence entre les deux images. L’utilisateur doit voir l’un des éléments et doit le demander avec précision et cohérence. Les données seront disponibles pour mettre en évidence les réponses et montrer l\'exactitude. \n\nCe niveau est l’un des plus rapides à progresser car l’utilisateur doit déjà être motivé par le renforçant de niveau 1.',
      'How do you know ready for level 3':
          'Comment savez-vous que l\'utilisateur est prêt pour le niveau 3?',
      'level2 How do you know ready for level 3':
          'L’utilisateur sera plus confiant lorsqu’il utilisera l’application de manière indépendante et le besoin de «passer la main» sera limité. \n\nLorsque l\'utilisateur appuie sur les boutons de manière indépendante et cohérente, avec un soutien limité de la part du parent / de l\'enseignant / du spécialiste, cela indique que l\'utilisateur est prêt pour le niveau 3.',
      'level3 name': 'Mauvais choix',
      'level3 summary':
          'À ce stade, l\'utilisateur comprendra que l\'application fournit un résultat qui lui procure du plaisir. Il est important que ce niveau soit fourni, car cette progression enseigne à l\'utilisateur que tous les choix ne sont pas gratifiants mais qu\'ils constituent une communication. Ce niveau est atteint en peu de temps. \n\nRésultat de l’apprentissage: il faut observer que l’utilisateur manifeste du dégoût pour la réception de l’option non préférée. L\'utilisateur ne choisira plus cette option.',
      'level3 Who does this level cater for':
          'Ce niveau s’adresse aux utilisateurs ayant accédé aux niveaux 1 et 2 et ayant un besoin minimal ou nul de passer de main en main. L’Utilisateur progresse en se voyant proposer une troisième option qui n’est pas un choix favorable.',
      'level3 How do we achieve this':
          'À ce stade de développement, l\'utilisateur aura désormais une option non privilégiée. Le parent / enseignant / spécialiste doit s\'assurer que la troisième image ajoutée à l\'écran est un élément non préféré, par exemple une chaussette. \n\nL\'utilisateur aura désormais la possibilité de demander deux options préférées et une option non préférée.',
      'select third reinforcer': 'Sélectionnez le troisième mot',
      'level3 How do we get the user to touch the screen':
          'L\'utilisateur doit maintenant être motivé par l\'application et sera intrigué pour toucher les images. Ils ont eu du plaisir avec les images à ce jour. L\'utilisateur sera curieux et devrait souhaiter recevoir un résultat positif de l\'élément non préféré. Elle / il devrait être motivé sans la sollicitation du parent / de l\'enseignant / du spécialiste. Toutefois, si ce n\'est pas le cas, le parent / l\'enseignant / le spécialiste doit suivre les stratégies du niveau 1 pour encourager cette interaction. \n\nSi l\'utilisateur sélectionne / touche l’une des trois images, ils recevront l’article instantanément. Les trois premiers niveaux sont conçus pour apprendre à l\'utilisateur comment demander un article. Ce niveau conforte le fait que tous les choix ne sont pas agréables, ce sont des demandes. L\'utilisateur va maintenant apprendre à considérer que les images qu\'il touche sont des éléments qu\'il reçoit, qu\'il les aime ou non.',
      'How do you know ready for level 4':
          'Comment savez-vous que l\'utilisateur est prêt pour le niveau 4?',
      'level3 How do you know ready for level 4':
          'L\'utilisateur sera déçu lors de la réception de l\'article non préféré et continuera à être satisfait des autres articles demandés. Le parent / enseignant / spécialiste devrait continuer à observer une confiance accrue dans l\'utilisation de l\'application de manière indépendante. \n\nLorsque l\'utilisateur appuie sur les boutons de manière indépendante et cohérente, sans aucune aide de la part du parent / de l\'enseignant / du spécialiste, l\'utilisateur est prêt pour le niveau 4. Les données prouvent ces observations. Il convient également d\'observer que l\'utilisateur manifeste du dégoût pour l\'option non préférée. L\'utilisateur ne choisira plus cette option.',
      'level4 name': 'Boîte vocale',
      'level4 summary':
          'Ce niveau est conçu pour commencer à construire la structure de langue qui sera utilisée dans les prochains niveaux. La récompense pour l’utilisateur ne sera remise qu’après avoir sélectionné l’image et touché la boîte vocale. \n\nRésultat de l’apprentissage: l’utilisateur sélectionnera un élément choisi et comprendra que celui-ci ne lui sera pas fourni / il touche la boîte vocale.',
      'level4 Who does this level cater for':
          'Ce niveau s’adresse aux utilisateurs ayant accédé aux niveaux 1 à 3 et utilisant désormais l’application indépendamment avec une prise en charge minimale / nulle. \n\nCe niveau est l’un des niveaux les plus difficiles pour le parent / enseignant / spécialiste et le plus frustrant pour l’utilisateur. Le but de ce niveau est d\'apprendre à l\'utilisateur à utiliser une boîte vocale permettant le développement du langage. À ce stade, le parent / enseignant / spécialiste envisage de développer un langage en préparant l\'utilisateur à utiliser un niveau de deux mots, c\'est-à-dire. veux du chocolat. Ce niveau prend du temps et de la patience. Cela peut nécessiter de revenir à «main sur main» pendant un court laps de temps.',
      'level4 How do we achieve this':
          'A ce stade, l\'écran de niveau 3 reste avec les trois mêmes options bien que l\'écran présente maintenant une longue bande en haut de l\'écran. Cette bande est appelée "boîte vocale". Lorsque l\'utilisateur touche les images habituelles, le mot ne sera plus prononcé immédiatement. Il sera maintenant affiché dans la boîte vocale en haut de l\'écran. L\'utilisateur doit maintenant toucher la boîte vocale pour permettre la prononciation des mots sélectionnés.',
      'level4 How do we get the user to touch the screen':
          'L\'utilisateur ne recevra plus de gratification instantanée lorsque l\'article est demandé. Elle / il doit être encouragé à toucher la boîte vocale. Pour cela, il faudra d\'abord «remettre la main» à l\'utilisateur et lui montrer ce qui est attendu. Tous les utilisateurs apprendront cela à un rythme différent. Le parent / enseignant / spécialiste doit progressivement réduire la "main sur la main" en fonction de la compréhension de l\'utilisateur.',
      'How do you know ready for level 5':
          'Comment savez-vous que l\'utilisateur est prêt pour le niveau 5?',
      'level4 How do you know ready for level 5':
          'L’Utilisateur choisira l’élément de manière indépendante ou avec le support «main sur main», puis touchera la boîte vocale. Les données indiqueront un taux de réussite élevé.',
      'level5 name': 'Vocabulaire de construction',
      'level 5 folders': 'Comportement des dossiers',
      'level 5 folder info':
          'Les dossiers ne sont pas affichés à ce niveau. C’est intentionnel afin que l’utilisateur ne puisse pas naviguer dans d’autres dossiers et ne détourne de l’objectif du niveau',
      'level5 summary':
          'Ce niveau marque le début du processus d’enseignement, l’objectif principal étant de créer un langage pour l’utilisateur. \n\nRésultat de l’apprentissage: l’utilisateur aura une compréhension claire de 6 mots ou plus dans un dossier.',
      'level5 Who does this level cater for':
          'This level caters for Users who have accessed Levels 1-4. Users will generally be using the App independently at this stage although some may require ‘hand over hand’ support. \n\nThis level is the start of the teaching process with the primary aim being to build language for the User. The parent/teacher/specialist role becomes more important at this stage as new words should now be introduced to the User, and the parent/teacher/specialist must select words that would be important to the User. The words must also be within the same category ie. using the example of chocolate would require building language for snack items, and the snack items must be those preferred by the User. The categories have been pre-arranged into folders and the words can be made visible as required. If the words/items are not currently available on the folder, the parent/teacher/specialist can take a photo and add them in.\n\nAt this stage, the parent/teacher/specialist must follow the guidance that is provided in the teaching section regarding the use of videos, cards and items. This level takes time and a lot of patience. ‘Hand over hand’ may continue until the User builds his/her confidence.',
      'level5 How do we achieve this':
          'The Parent/Teacher/Specialist section within the App provides detail on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. \n\nThis section includes:\n1.	Continuing to request items\n2.	Matching pictures\n3.	Matching picture to object\n4.	Matching picture to item',
      'level5 How do we get the user to touch the screen':
          'This level requires the User to focus and remain seated to improve communication and build vocabulary. It is unlikely that the User will be willing to engage and therefore it is essential that the main reinforcer is re-introduced. The main reinforcer discussed as an example in the previous summaries was chocolate. In this case the chocolate must be readily available throughout these sessions as the User will be motivated to work if they are provided with a reward. \n\nInitially, the User should be rewarded with their reinforcer after EVERY successful item has been requested ie. when matching every item, the User should be rewarded with a small treat such as a third of a chocolate button. Gradually reduce the reinforcer treat as the User becomes more confident. In time, the User will no longer require a reinforcer. \n\For many this may require ‘hand over hand’ to initially teach the User and show what is expected. All Users will learn this at a different rate. The parent/teacher/specialist should gradually reduce the ‘hand over hand’ depending on the understanding of the User.',
      'How do you know ready for level 6':
          'How do you know the user is ready for level 6?',
      'level5 How do you know ready for level 6':
          'The User will have developed words within this category ie. snacks. This category will continue to be known as the ‘snack’ folder. When a folder contains 6 or more items the User is ready to progress to Level 6. The User would be expected to select items independently although some Users may still prefer ‘hand over hand’ support at this time. Data will continue to be available to show a high percentage success rate in identifying the chosen items. ',
      'level6 name': 'Creating folders',
      'level6 summary':
          'This Level allows Users to develop their language by increasing folders. Folders are created to allow Users to compartmentalize different topics ie. food, transport, clothes. \n\nLearning outcome: The User will show confidence in selecting items. They will be able to move between a minimum of three folders with ease.',
      'level6 Who does this level cater for':
          'This level differs from the others in that it caters for two groups:\n1.	Users who have accessed levels 1-5. These Users will be developing in confidence and most will be using the App independently. Some Users may still require extra support with ‘hand over hand’. Do not discourage this as all Users will develop at a different rate – as confidence grows, the need for support will reduce. \n2.	This would be the suggested stage to introduce the App to Users with limited/zero communication who are visual learners with moderate to good understanding. The parent/teacher/specialist should familiarize themselves with the teaching strategies employed in Levels 1-5 to promote maximum progress and understanding.\n\nThis Level allows Users to develop their language by increasing folders. Folders are created to allow Users to compartmentalize different topics ie. food, transport, clothes. \n\nThe Users who have accessed Levels 1-5 should be engaged and have a clear understanding of what is expected of them. This level allows the parent/teacher/specialist to add different folders to increase the language/speech opportunities. Consider this level as being similar language development for any individual learning a new language. Typical language development starts with one word ie. juice, cat, car. The words come from different folders. We, at Lucas Education, have created a template of folders that we believe are essential for day-to-day communication.',
      'level6 How do we achieve this':
          'One additional folder will be made available to the existing folder in Level 5. For new Users, two folders will be available. The parent/teacher/specialist selects a second folder which contains items that are motivating to the User. When data shows that the User has clearly understood 5 words, the App with allow the opportunity to unlock 5 more words within this folder as well as another folder. \n\nThis process will continue as your User continues to develop and grow. This is a natural process and the same process that all individuals go through when learning to speak and communicate. Level 6 is on-going learning and development.   \n\nThe Parent/Teacher/Specialist section within the App provides further detail on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. Games will be available in due course.\n\nThis section includes:\n1.	Continuing to request items\n2.	Matching pictures\n3.	Matching picture to object\n4.	Matching picture to item',
      'level6 How do we get the user to touch the screen':
          'This Level continues to require the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the program on the move. Examples of such opportunities are when seated in the car or maybe your child enjoys sitting in their pram.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be motivated to work if they are provided with a reward. It is important however to reduce the frequency of the reward. As the language develops, the reinforcer should be reduced and removed.  \n\nThis may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication.',
      'How do you know ready for level 7':
          'How do you know the user is ready for level 7?',
      'level6 How do you know ready for level 7':
          'The User will show confidence in selecting items. They will be able to move between a minimum of three folders with ease. Data will continue to be available to show a high percentage success rate in identifying the chosen items.',
      'level7 name': 'Sentence structure – part one',
      'level7 summary':
          'This Level allows Users to develop sentence structure by introducing a sentence starter. Folders are predesigned to predict possible sentence starters for each folder. \n\nLearning outcome: The User will show confidence in selecting the sentence starter followed by the chosen item. The words will be activated by pressing the voicebox.',
      'level7 Who does this level cater for':
          'This level caters for Users who have accessed Level 6.\n\nThis Level allows Users to develop sentence structure by introducing a sentence starter. Folders are predesigned to predict possible sentence starters for each folder. The option is also available to personalise words.',
      'level7 How do we achieve this':
          'In the previous section, typical language development was discussed. This section takes language development to the next level. Children move from one word level to two. We, at Lucas Education achieve this by introducing sentence starters which vary depending on the folder. Examples of this would be as follows:\n1.	Food folder – I want chocolate……I do not want chocolate.\n2.	Animal folder – I hear cat\n3.	Transport folder – I see car.\n\nSimilar to Level 4, the User may become frustrated during the initial stages of this Level as they are now expected to include a word prior to what has been expected of them in previous levels. For many reinforcers must be introduced again to ensure that the User remains motivated. \n\nAs with the previous folder the words/images will be released when data proves that the User is capable of understanding and consistently includes the sentence starter before requests. Level 7 is on-going learning and development.   \n\nThe Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources.',
      'level7 How do we get the user to touch the screen':
          'This Level also requires the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the programme on the move. Examples of such opportunities are when seated in the car or maybe your child enjoys sitting in their pram.\n\nOnce both icons, namely the sentence starter and the requested item, are appearing in the voice box, the User must touch the voice box and the App will say the sentence for example “I want chocolate” At this point the parent/teacher will give the User what he/she is requesting. The voice box should not be activated until an action and an image are added. Both icons must be spoken in the one voice box; they cannot be selected and spoken independently.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be more motivated to work if they are provided with a reward. This may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication. ',
      'How do you know ready for level 8':
          'How do you know the user is ready for level 8?',
      'level7 How do you know ready for level 8':
          'The User will show confidence in selecting the sentence starter followed by the chosen item. Data will continue to be available to show a high percentage success rate in identifying the chosen items and more sentence starters will be unlocked to develop language further.',
      'level8 name': 'Sentence structure – part two',
      'level8 summary':
          'This level caters for Users who have accessed Level 7.\n\nThis Level allows Users to develop sentence structure by including a sentence closer. Folders are predesigned to predict possible sentence closers for each folder. The option is also available to personalise words.',
      'level8 Who does this level cater for':
          'This level caters for Users who have accessed Level 7.\n\nThis Level allows Users to develop sentence structure by including a sentence closer. Folders are predesigned to predict possible sentence closers for each folder. The option is also available to personalise words.',
      'level8 How do we achieve this':
          'In Level 5, typical language development was promoted and in Level 6 the sentence starters were added. This Level progresses language development to the next level by closing the sentences. We, at Lucas Education achieve this by providing predicted sentence closers which vary depending on the folder. Examples of this would be as follows:\n1.	Food folder – I want chocolate please\n2.	Animal folder – I hear cat\n3.	Transport folder – I see car.\n\nThe final part of the sentences can or cannot be used in conjunction with the action and objects. For example in some cases, the closing part can be used alone eg. All done!\n\nSimilar to Levels 4 and 7, the User may become a little frustrated during the initial stages of this Level as they are now expected to include a word following what has been expected of them in previous levels. For many, reinforcers must be introduced again to ensure that the User remains motivated. \n\nAs with the previous folder the words/images will be released when data proves that the User is capable of understanding and consistently includes the sentence closer after requests. Level 8 is on-going learning and development.\n\The Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. ',
      'level8 How do we get the user to touch the screen':
          'This Level also requires the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the programme on the move. Such opportunities could be made possible at snack time or perhaps when ordering food at a takeaway.\n\nWhen all three icons, namely the sentence starter, the requested item and the sentence closer, are appearing in the voice box, the User must touch the voice box and the App will say the sentence, for example “I want chocolate, please!”. At this point the parent/teacher will give the person what she/he is requesting. The voice box should not be activated until an action, an image and a closer are added. All three icons must be spoken in the one voice box; they cannot be selected and spoken independently.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be more motivated to work if they are provided with a reward. This may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication.',
      'How do you know ready for level 9':
          'How do you know the user is ready for level 9?',
      'level8 How do you know ready for level 9':
          'The User will show confidence in selecting the sentence starter followed by the chosen item and sentence closer. Data will continue to be available to show a high percentage success rate in identifying the chosen items and more sentence closers will be unlocked to develop language further. \n\nUsers at this Level are now capable of accessing Levels 9, 10 and 11. All three Levels are challenging and cater for higher functioning Users. These Levels do not have to taught in a sequential order, for example, the User may find difficulty in progressing through Levels 9 and 10, but may succeed in Level 11.',
      'level9 name': 'Grammar and developed literacy',
      'level9 summary':
          'This Level allows higher functioning Users the opportunity to focus on building sentence structure by developing literacy through use of conjunctions, connectives and pronouns.\nThis is an important building block to teaching the User how to read. \n\nTHIS IS ONE OF THE MORE CHALLENGING LEVELS.\n\nLearning outcome: The User will have the ability to communicate with confidence by linking words with conjunctives and using other literacy cues to develop language further.',
      'level9 Who does this level cater for':
          'This level caters for Users who have accessed Level 8.\n\nThis Level allows higher functioning Users the opportunity to focus on building sentence structure by developing literacy through use of conjunctions, connectives and pronouns.\n\nTHIS IS ONE OF THE MORE CHALLENGING LEVELS.',
      'level9 How do we achieve this':
          'The Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. \n\nData will also assist in gathering success criteria and in unlocking progressive language.',
      'level9 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program. ',
      'How do you know ready for level 10':
          'How do you know the user is ready for level 10?',
      'level9 How do you know ready for level 10':
          'The User is capable to access Level 10 directly from Level 8. All Levels can be used at the same time to develop language. Words will be unlocked when data dictates that the User is ready. ',
      'level10 name': 'Learning words',
      'level10 summary':
          'This Level allows higher functioning Users the opportunity to focus on learning words as opposed to pictures. This Level progresses by removing pictures and replacing them with the name/text of each object. This is the initial step in providing our non-verbal children with the opportunity to read.\n\nLearning outcome: The User will have the ability to communicate with the same confidence by using words as opposed to images.',
      'level10 Who does this level cater for':
          'This level caters for Users who have accessed Level 8 or 9.\n\nThis Level allows higher functioning Users the opportunity to focus on learning words as opposed to pictures. Users who require images should bypass this Level and access Level 10.',
      'level10 How do we achieve this':
          'The Parent/Teacher/Specialist will have an understanding of the favourite words selected by the User. Data will also assist in gathering such details. All words have been set up to show a large image with a small defined word below (show example). The Parent/Teacher/Specialist will now gradually reduce the size of the picture for the favourite words, whilst increasing the size of the word. With time the Parent/Teacher/Specialist will aim to remove the image and only provide the User with the word. Once again, experience and data will provide feedback on the understanding of the User and their readiness to remove images from other buttons.',
      'level10 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program. If they are unable to use the words when the images have been reduced, this is a sign that the User is not ready for this Level and it must be revisited at another stage.',
      'How do you know ready for level 11':
          'How do you know the user is ready for level 11?',
      'level10 How do you know ready for level 11':
          'The User will show confidence in selecting icons with words as opposed to images. Data will continue to be available to show a high percentage success rate in identifying the chosen items.',
      'level11 name': 'predictive images/writing',
      'level11 summary':
          'This Level allows Users the opportunity to communicate with greater speed by providing the User with the opportunity to select predicted images or words. \n\nLearning outcome: The User will have the ability to communicate with the same confidence although at a greater speed and fluency.',
      'level11 Who does this level cater for':
          'This level caters for Users who have accessed Level 8.\n\nThis Level allows Users the opportunity to communicate with greater speed. ',
      'level11 How do we achieve this':
          'This Level provides the User with the opportunity to select predicted images or words. The App will provide a list of actions to be selected by the user. Once an action is selected, the pictures/words to be shown will be presented depending on the frequency of usage for each word. The most used words will appear higher in the grid while less used words for that specific action will appear lower on the grid.',
      'level11 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program',
    },
    // German (229 million)
    'de': {
      'app title': 'LUCAS',
      'relation': 'Beziehung',
      'schedule day': 'Planen Sie den Tag',
      'sound': 'Klang',
      'video': 'Video',
      'story object': 'Story-Objekt',
      'translation': 'Übersetzung',
      'start': 'Sicherung starten',
      'backup device': 'Sichern Sie dieses Gerät',
      'Minimum level to show': 'Mindestniveau zu zeigen',
      'background color': 'Hintergrundfarbe',
      'loading empty spaces': 'Leere Räume laden',
      'loading translations': 'Übersetzungen laden',
      'Drag and drop enabled': 'Drag & Drop aktiviert',
      'Drag and drop disabled': 'Drag & Drop deaktiviert',
      'about this app': 'Über diese App',
      'text to find': 'Finden',
      'text to find instructions':
          'Geben Sie das Wort oder einen Teil des Wortes ein, das in der Frage zu finden ist. Lassen Sie das Feld leer, um nach allen zu suchen.',
      'number of concepts': 'Anzahl der Konzepte',
      'one concept': 'Ein Konzept',
      'two concepts': 'Zwei Konzepte',
      'three or more': 'Drei oder mehr Konzepte',
      'students': 'Studenten',
      'find results': 'Ergebnisse finden',
      'result is correct': 'Ergebnis ist korrekt',
      'result is wrong': 'Ergebnis ist falsch',
      'play quiz': 'Hören Sie sich das Quiz an',
      'silent quiz ongoing': 'Stilles Quiz läuft',
      'send to device': 'Senden an:',
      'quiz type': 'Art des Quiz',
      'quiz show image': 'Bilder anzeigen',
      'quiz sound image': 'Sprechen Sie die Konzepte aus',
      'quiz show sound and image':
          'Sprechen Sie die Konzepte aus und zeigen Sie Bilder',
      'quiz do not show anything': 'Zeige nichts',
      'send quiz': 'Quiz senden',
      'schedule_title1': 'Herzlich willkommen',
      'schedule_title2': 'Uhrzeit',
      'schedule_title3': 'Bearbeitungsmodus',
      'schedule_title4': 'Objekt hinzufügen',
      'schedule_title5': 'Tage verwalten',
      'schedule_text1':
          'Der Zeitplan ermöglicht es, Dinge zu visualisieren, die passieren werden. Dadurch kann Ihr Benutzer verstehen, was er heute und in Zukunft tun wird. Sie können ein Element lange drücken, um es zu vergrößern.',
      'schedule_text2':
          'Verstecke / zeige die Tageszeit, zu der jede Aktivität stattfinden wird.',
      'schedule_text3':
          'Der Bearbeitungsmodus ermöglicht die Verwaltung von Konzepten. Im Bearbeitungsmodus werden alle Tage angezeigt und Sie können auf jedes Objekt klicken, um mit ihm zu interagieren.',
      'schedule_text4':
          'Wählen Sie den Tag / die Uhrzeit und das Bild aus, die angezeigt werden sollen.',
      'schedule_text5':
          'Wenn Sie neue Tage hinzufügen müssen, klicken Sie hier.',
      'existing concept':
          'Es gibt bereits ein Konzept für denselben Tag und dieselbe Stunde. Bitte korrigieren und erneut versuchen.',
      'please select an object': 'Bitte wählen Sie ein Objekt aus',
      'please select a day': 'Bitte wählen Sie einen Tag',
      'select an object': 'Wählen Sie ein Objekt aus',
      'add object': 'Objekt zum Zeitplan hinzufügen',
      'select day': 'Tag auswählen',
      'selected day': 'Ausgewählter Tag',
      'select hour': 'Stunde auswählen',
      'monday': 'Montag',
      'tuesday': 'Dienstag',
      'wednesday': 'Mittwoch',
      'thursday': 'Donnerstag',
      'friday': 'Freitag',
      'saturday': 'Samstag',
      'sunday': 'Sonntag',
      'school': 'Schule',
      'home': 'Zuhause',
      'today': 'Heute',
      'tomorrow': 'Morgen',
      'no action required title': 'Es ist keine Aktion erforderlich',
      'no action required info':
          'Bitte lesen Sie die bereitgestellten Informationen und fahren Sie fort, indem Sie auf das Symbol Lernen klicken',
      'reset': 'Zurücksetzen',
      'video_title1': 'Einführungsvideo',
      'video_title2': 'Stufe 1',
      'video_title3': 'Stufe 2',
      'video_title4': 'Stufe 3',
      'video_title5': 'Stufe 4',
      'video_title6': 'Stufe 5',
      'video_title7': 'Stufe 6',
      'video_title8': 'Stufe 7',
      'video_title9': 'Stufe 8',
      'video_title10': 'Stufe 9',
      'video_title11': 'Stufe 10',
      'video_title12': 'Stufe 11',
      'video_title13': 'Benutzereinstellungen',
      'video_text1': 'Unser Einführungsvideo',
      'video_text2': 'Verstärkungsvideo',
      'video_text3': 'Wählt Video',
      'video_text4': 'Video mit schlechten Entscheidungen',
      'video_text5': 'Voice-Box-Video',
      'video_text6': 'Aufbau eines Vokabularvideos',
      'video_text7': 'Ordnervideo erstellen',
      'video_text8': 'Satzstruktur - Teil eins Video',
      'video_text9': 'Satzstruktur - Teil zwei Video',
      'video_text10': 'Grammatik und entwickeltes Alphabetisierungsvideo',
      'video_text11': 'Video lernen Wörter',
      'video_text12': 'Vorausschauende Bilder / Video schreiben',
      'video_text13': 'Video mit Benutzereinstellungen',
      'showHelper_LevelSettings_title1': 'Zuerst:',
      'showHelper_LevelSettings_title2': 'Informationen ausfüllen',
      'showHelper_LevelSettings_title3': 'Level ändern',
      'showHelper_LevelSettings_title4': 'Lernbildschirm',
      'showHelper_LevelSettings_text1':
          'Bitte lesen Sie alle Informationen, die wir für Sie bereitgestellt haben',
      'showHelper_LevelSettings_text2':
          'Einige Ebenen erfordern Informationen von Ihrer Seite. Sie sind deutlich hervorgehoben',
      'showHelper_LevelSettings_text3':
          'Wenn Sie die Ebenen ändern müssen, drücken Sie bitte dieses Symbol',
      'showHelper_LevelSettings_text4':
          'Wenn Sie fertig sind, kehren Sie zum Lernbildschirm zurück',
      'showHelper_image-settings_title1': 'Finden',
      'showHelper_image-settings_title2': 'Bearbeiten',
      'showHelper_image-settings_title3': 'Rastergröße',
      'showHelper_image-settings_title4': 'Hilfe',
      'showHelper_image-settings_text1':
          'Geben Sie den Text ein und drücken Sie die Taste, um die Bilder zu finden',
      'showHelper_image-settings_text2':
          'Klicken Sie auf das Bild, um es zu bearbeiten',
      'showHelper_image-settings_text3':
          'Ändern Sie die Rastergröße durch Drücken dieser Taste',
      'showHelper_image-settings_text4':
          'Schalten Sie die Hilfe mit dieser Schaltfläche ein oder aus',
      'showHelper_folders_title1': 'Klicken',
      'showHelper_folders_title2': 'Doppelklick',
      'showHelper_folders_title3': 'Lange drücken',
      'showHelper_folders_title4': 'Hinzufügen',
      'showHelper_folders_title5': 'Zurück zum übergeordneten Ordner',
      'showHelper_folders_text1':
          'Klicken Sie auf ein Element, um dessen Eigenschaften anzuzeigen',
      'showHelper_folders_text2':
          'Doppelklicken Sie auf einen Ordner, um dessen untergeordnete Elemente anzuzeigen',
      'showHelper_folders_text3':
          'Drücken Sie lange auf einen Gegenstand, um ihn zu sperren / entsperren',
      'showHelper_folders_text4':
          'Fügen Sie Ordner, Bilder, Sounds und Videos hinzu',
      'showHelper_folders_text5':
          'Um zum übergeordneten Ordner zurückzukehren, drücken Sie dieses Symbol',
      'Show Help Screens': 'Hilfebildschirme anzeigen',
      'privacy policy': 'Datenschutz-Bestimmungen',
      'must accept privacy policy':
          'Sie müssen unsere Datenschutzbestimmungen akzeptieren, bevor Sie fortfahren können',
      'view privacy policy': 'Datenschutzbestimmungen anzeigen',
      'accept privacy policy': 'Datenschutzbestimmungen akzeptieren',
      'show hide schedule': 'Zeitplan ein- / ausblenden',
      'show hide stories and schedule':
          'Anzeigen oder Ausblenden der Geschichten und des Zeitplans',
      'show': 'Show',
      'hide': 'Ausblenden',
      'share item': 'Teilen',
      'check connection': 'Verbindung prüfen',
      'not connected to internet':
          'Sieht aus wie Sie nicht mit dem Internet verbunden sind',
      'user information': 'Nutzerinformation',
      'settings restrictions instructions':
          'Der Zugriff auf die Konfiguration kann eingeschränkt werden. Dies ist nützlich, wenn der Benutzer versucht, auf das Konfigurationssymbol zu klicken, das ihn vom Lernprozess ablenkt. Wenn die Konfigurationseinschränkung aktiviert ist, muss die Antwort auf ein einfaches mathematisches Problem angegeben werden. Wenn die Antwort richtig ist, wird der Zugriff auf den Konfigurationsabschnitt gewährt. Mit diesem Einschränkungsmechanismus können Eltern und Lehrer den Zugriff auf den Konfigurationsabschnitt einschränken, ohne sich Kennwörter merken und teilen zu müssen.',
      'settings password protected': 'Einstellungsbeschränkungen',
      'settings password protected no': 'Keine Einschränkungen',
      'settings password protected yes':
          'Beantragen Sie eine mathematische Antwort',
      'delete linked device': 'Verknüpftes Gerät löschen',
      'confirm delete linked device':
          'Möchten Sie das verknüpfte Gerät löschen? Wenn Sie es löschen, müssen Sie es später erneut verknüpfen, um es wieder hinzuzufügen.',
      'echo device': 'Dieses Gerät gibt die Sprachbox wieder',
      'device silent': 'Dieses Gerät bleibt stumm',
      'device blocked': 'Das Gerät ist jetzt gesperrt.',
      'device unblocked': 'Das Gerät wurde entsperrt.',
      'output voicebox to device': 'Sprachbox an ein anderes Gerät ausgeben',
      'quizzes': 'Quiz',
      'quizzes instructions':
          'Auf diesem Gerät können Quizfragen (als Lehrer / Erzieher) erstellt werden (Quizfragen können auf jedem Gerät beantwortet werden).',
      'can create quiz': 'Kann Quiz erstellen',
      'can not create quiz': 'Kann kein Quiz erstellen',
      'invite rejected': 'Einladung abgelehnt von',
      'invite sent': 'Einladung gesendet an',
      'recieved invite': 'Sie haben eine Einladung zum Verlinken erhalten',
      'accept': 'Akzeptieren',
      'ignore and dismiss': 'Ignorieren und entlassen',
      'invite confirmed': 'Einladung bestätigt zu',
      'invite accepted': 'Einladung angenommen von',
      'remember link other party':
          'Denken Sie daran: Wiederholen Sie den gleichen Vorgang auf dem anderen Gerät.',
      'please enter remote email':
          'Bitte geben Sie die E-Mail-Adresse des anderen Teilnehmers ein',
      'add new device': 'Neues Gerät hinzufügen',
      'remote user email': 'Remote-Benutzer-E-Mail',
      'remote user email instructions':
          'Um eine Verbindung zwischen zwei Geräten herzustellen, stellen Sie sicher, dass beide Geräte eingeschaltet sind, eine Internetverbindung haben, die APP ausgeführt wird und der Bildschirm für verknüpfte Geräte (dieser Bildschirm) angezeigt wird. Der Verbindungsaufbau muss auf beiden Geräten ausgeführt werden (jedes Gerät muss die E-Mail-Adresse des anderen Teilnehmers eingeben)',
      'enter remote user email':
          'Geben Sie die E-Mail-Adresse des Remote-Benutzers ein',
      'warning': 'Warnung',
      'email or name not filled':
          'E-Mail oder Name nicht ausgefüllt. Bitte vervollständigen Sie diese Informationen, bevor Sie versuchen, neue Geräte zu verknüpfen.',
      'email or name required for backup':
          'E-Mail oder Name nicht ausgefüllt. Bitte vervollständigen Sie diese Informationen, bevor Sie versuchen, das Gerät zu sichern.',
      'email or name required for restore':
          'Für die Wiederherstellung ist eine E-Mail erforderlich',
      'start restore': 'Starten Sie die Wiederherstellung',
      'replace folder': 'Ordner ersetzen',
      'add to folder': 'Zum Ordner hinzufügen',
      'what to do with folder':
          'Wählen Sie den lokalen Ordner aus, der ersetzt werden soll. Es wird empfohlen, dieses Gerät vor dem Wiederherstellen eines Ordners zu sichern, da der Inhalt des lokalen Ordners gelöscht wird, bevor er durch den Remote-Ordner ersetzt wird.',
      'choose folder to restore':
          'Wählen Sie den Ordner aus, der wiederhergestellt werden soll',
      'quiz': 'Prüfung',
      'linked devices': 'Verknüpfte Geräte',
      'no linked devices': 'Es wurden keine verknüpften Geräte gefunden',
      'change user name': 'Benutzernamen ändern',
      'confirm change user name': 'Möchten Sie den Benutzernamen ändern?',
      'user name': 'Nutzername',
      'user name hint': 'Geben Sie den Namen des Benutzers ein',
      'change user email': 'Ändern Sie die E-Mail',
      'confirm change user email':
          'Wenn Sie die E-Mail-Adresse des Benutzers ändern, müssen Sie die Geräte neu verknüpfen (der Elternteil oder der Erzieher müssen den Link zu diesem Gerät neu erstellen). Möchtest du weiter machen?',
      'user email': 'E-Mail des Benutzers',
      'user email instructions':
          'Geben Sie die vom Benutzer zu verwendende E-Mail-Adresse ein. Dies kann die E-Mail-Adresse des Elternteils sein, wenn der Benutzer keine hat. Geben Sie nicht die E-Mail-Adresse des Erziehers oder Lehrers in dieses Feld ein. Die E-Mail wird verwendet, um jeden Benutzer als eindeutig zu identifizieren. Die E-Mail wird verwendet, um Geräte für die Synchronisierung oder Tests zu verknüpfen.',
      'user email hint': 'Email eingeben',
      'toggle visibility for all': 'Sichtbarkeit aller Konzepte ändern',
      'item availability': 'Artikelverfügbarkeit',
      'item availability instructions':
          'Wenn ein Artikel nicht verfügbar ist, können Sie ihn angeben. Nicht verfügbare Elemente werden mit einem roten X über dem Bild angezeigt',
      'is available': 'Ist verfügbar',
      'is not available': 'Ist nicht verfügbar',
      'not available': 'Nicht verfügbar',
      'available': 'Verfügbar',
      'delete story': 'Story löschen',
      'confirm delete story': 'Möchten Sie die Story wirklich löschen?',
      'level not enabled': 'Level nicht aktiviert',
      'not enough data':
          'Predictive Writing ist nicht aktiviert, da nicht genügend Daten erfasst wurden',
      'image size': 'Bildgröße',
      'text size': 'Textgröße',
      'small': 'Klein',
      'medium': 'Mittel',
      'large': 'Groß',
      'select video': 'Video auswählen',
      'selected video': 'Ausgewähltes Video:',
      'recording': 'Aufzeichnung...',
      'story object instructions':
          'Sie können Konzepte verwerfen, indem Sie sie durchziehen. Nichts wird gelöscht. (Konzepte werden nur im Bearbeitungsmodus gelöscht)',
      'edit story name': 'Bearbeiten Sie den Namen der Story',
      'select this concept': 'Wählen Sie dieses Konzept',
      'no story object instructions': '',
      'add story object': 'Konzept hinzufügen',
      'story name hint': 'Geben Sie den Namen der Story ein',
      'create new story': 'Erstelle eine neue Geschichte',
      'no stories instructions':
          'Mit Geschichten können Sie Konzepte (Bilder, Töne und Videos) verbinden, um neue Ideen zu erläutern. Zum Beispiel können Sie einen Zoobesuch erklären, der mit Duschen, Anziehen, Frühstücken, Reisen mit dem Auto und Tierbeobachtungen beginnt.',
      'add story': 'Geschichte hinzufügen',
      'please confirm': 'Bitte bestätigen',
      'replace sound confirmation':
          'Möchten Sie das vorhandene Audio ersetzen?',
      'replace': 'Ersetzen',
      'voiceBoxSize': 'Voice-Box-Größe',
      'big': 'Groß',
      'select sound': 'Ton aufnehmen',
      'select sound instructions':
          'Nehmen Sie den gewünschten Ton auf. Dieses Audio kann wiedergegeben werden, wenn der Benutzer auf das Bild klickt.',
      'delete': 'Löschen',
      'delete confirmation':
          'Bitte bestätigen Sie, dass Sie dieses Objekt löschen möchten. Dieser Vorgang ist irreversibel.',
      'warning not user created':
          'WARNUNG: Dieses Objekt wird standardmäßig mit der APP gebündelt. Wenn Sie es löschen, können Sie es nicht wiederherstellen, und Sie müssen es manuell mit Bild und Text in jeder Sprache hinzufügen.',
      'folder not empty will not delete':
          'Der Ordner muss vor dem Löschen leer sein',
      'local device': 'Gerät',
      'library': 'Bibliothek',
      'camara': 'Kamera',
      'folder should talk': 'Sagen Sie den Namen des Ordners',
      'folder should talk instructions':
          'Aktivieren Sie diese Option, wenn Sie den Namen des Ordners hören möchten, wenn Sie darauf klicken.',
      'loading images': 'Laden von Bildern',
      'loading folders': 'Ordner laden',
      'loading relations': 'Laden von Beziehungen',
      'loading categories': 'Kategorien werden geladen',
      'loading videos': 'Videos werden geladen',
      'loading sounds': 'Laden von Sounds',
      'allowLongPressInLearningScreen':
          'Erlaube langes Drücken eines Konzepts im Lernmodus',
      'long press instructions':
          'Wenn der Benutzer im Lernmodus lange auf ein Konzept drückt, wird ein Bildschirm mit detaillierten Informationen zur ausgewählten Option angezeigt.',
      'Not assigned': 'Nicht zugeordnet',
      'nothing unlocked': 'Nichts freigeschaltet',
      'nothing unlocked instructions':
          'Bevor Sie dieses Raster verwenden können, müssen Sie die gewünschten Konzepte auswählen (anzeigen / entsperren). Sperren / Entsperren Sie die Konzepte, indem Sie sie gedrückt halten. Denken Sie daran, dass die Ordner in dieser Ebene nicht angezeigt werden.',
      'please unlock':
          'Bitte entsperren / sichtbar machen Sie die gewünschten Elemente in Konfiguration, Ordner',
      'default folder': 'Standard Ordner',
      'c': 'Ordner öffnen',
      'default folder instructions':
          'Um diesen Ordner als Standardordner auszuwählen, klicken Sie auf die Schaltfläche',
      'understood': 'Verstanden',
      'not understood': 'Nicht verstanden',
      'is understood': 'Konzept wird verstanden',
      'is not understood': 'Konzept ist noch nicht verstanden',
      'conceptIsUnderstood': 'Konzept Verständnis',
      'conceptIsUnderstoodInstructions':
          'Sobald der Benutzer das klare Konzept hat, markieren Sie es als verstanden. Dies hilft Lehrern und Eltern bei der Kommunikation. Alle verstandenen Konzepte sind im Lernraster grün umrahmt.',
      'object visible': 'Objekt ist aktuell sichtbar',
      'object not visible': 'Objekt ist derzeit nicht sichtbar',
      'visibility': 'Sichtweite',
      'visibility instructions':
          'Zeigen Sie die gewünschten Bilder an oder blenden Sie sie aus (entsperren / sperren)',
      'image to show': 'Bild zu zeigen',
      'text to show': 'Zu zeigender Text',
      'text to show instructions':
          'Dies ist der Text, der unter jedem Bild im Lerngitter angezeigt wird.',
      'text to show hint': 'Geben Sie den anzuzeigenden Text ein',
      'text to say': 'Text zu sagen',
      'text to say instructions':
          'Sie können ändern, was zu sagen ist! Anstatt "Mein Name ist ..." zu sagen, können Sie ihn in "Mein Name ist [Name hier einfügen]" oder "Meine Schwester ist [Name der Schwester]" ändern. Es ist auch nützlich, einen kurzen Text zum Anzeigen zu haben, aber einen langen Text zum Sagen, beispielsweise wenn ein Bild eine lange Phrase darstellt.',
      'text to say hint': 'Geben Sie den zu sagenden Text ein',
      'edit': 'Bearbeiten',
      'no default folder': 'Standardordner nicht ausgewählt',
      'please select a default folder':
          'Wählen Sie einen Standardordner. Es werden nur die Bilder angezeigt, die Sie aus diesem Ordner freigeschaltet haben.',
      'select folder': 'Wählen Sie den Standardordner',
      'select a folder':
          'Wählen Sie den Remote-Ordner aus, den Sie importieren möchten',
      'current default folder': 'Aktueller Standardordner:',
      'unlock': 'Freischalten',
      'lock': 'Sperren',
      'debug mode': 'Debug-Modus',
      'user profile': 'Benutzereinstellungen',
      'add': 'Hinzufügen',
      'Grid size': 'Gittergröße',
      'grid size instructions':
          'Wenn Sie möchten, können Sie die Größe des Rasters (Spalten und Zeilen) ändern. Ändern Sie diese Einstellung nur, wenn Sie ein Gerät mit einem großen Bildschirm haben. Stellen Sie sicher, dass der Benutzer jedes Symbol bequem sehen und berühren kann.',
      'operation completed successfully': 'Operation erfolgreich abgeschlossen',
      'restore device': 'Gerät wiederherstellen',
      'user email to restore': 'Benutzer-E-Mail zum Wiederherstellen',
      'categories': 'Kategorien',
      'category': 'Kategorie',
      'close': 'Schließen',
      'add folder': 'Ordner hinzufügen',
      'add image': 'Bild hinzufügen',
      'add empty': 'Leeren Raum hinzufügen',
      'add video': 'Video hinzufügen',
      'add sound': 'Sound hinzufügen',
      'new folder name': '',
      'new image name': '',
      'new video name': '',
      'new sound name': '',
      'show folder': 'Ordner anzeigen',
      'hide folder': 'Ordner ausblenden',
      'delete folder': 'Lösche Ordner',
      'folder instructions':
          'Klicken oder doppelklicken Sie auf ein Bild oder einen leeren Bereich, um dessen Optionen zu aktivieren. Klicken Sie auf das Menü, um weitere Optionen anzuzeigen.',
      'grid instructions':
          'Abhängig von den Bedürfnissen des Benutzers (für größere Symbole) oder der Größe des Bildschirms des Geräts können Sie die Rastergröße der angezeigten Bilder ab Stufe 5 ändern.',
      'grid': 'Gitter',
      'Columns': 'Säulen',
      'Rows': 'Reihen',
      'folders': 'Ordner',
      'level not found': 'Level nicht gefunden',
      'missing reinforcer': 'Fehlender Verstärker',
      'confirm reinforcer': 'Bitte bestätigen Sie, dass Sie verwenden möchten ',
      'selected reinforcer': 'Ihre aktuell ausgewählte Verstärkung ist:',
      'please select a reinforcer':
          'Bitte wählen Sie eine Verstärkung für diese Stufe',
      'cancel': 'Stornieren',
      'learn': 'Lernen',
      'stories': 'Geschichten',
      'schedule': 'Zeitplan',
      'help videos': 'Hilfevideos',
      'images': 'Bilder',
      'colors': 'Farben',
      'amber': 'Bernstein',
      'blue': 'Blau',
      'cyan': 'Cyan',
      'deepOrange': 'Tiefes Orange',
      'deepPurple': 'Dunkellila',
      'green': 'Grün',
      'indigo': 'Indigo',
      'lightBlue': 'Hellblau',
      'lightGreen': 'Hellgrün',
      'lime': 'Limette',
      'orange': 'Orange',
      'pink': 'Rosa',
      'purple': 'Lila',
      'red': 'Rot',
      'teal': 'Blaugrün',
      'yellow': 'Gelb',
      'dark mode': 'Dunkler Modus',
      'select this theme': 'Wählen Sie dieses Thema',
      'select voice': 'Stimme auswählen',
      'no voice selected':
          'Keine Stimme ausgewählt. Wenn Sie keine Stimme auswählen, kann die APP kein Wort sagen.',
      'tts': 'Text zu Sprache',
      'voice speed': 'Sprachgeschwindigkeit',
      'say': 'Sag es laut',
      'send by email': 'Per E-Mail gesendet',
      'user name not configured': 'Benutzername nicht konfiguriert',
      'change': 'Veränderung',
      'no valid voice found': 'Es wurde keine gültige Stimme gefunden',
      'test voice': 'Stimme testen. Klicken Sie zum Aktivieren.',
      'test text':
          'Wenn Sie diesen Satz hören, haben Sie die Stimme richtig konfiguriert.',
      'settings title': 'Aufbau',
      'levels': 'Ebenen',
      'language': 'Sprache',
      'select language instructions': 'Wählen Sie Ihre bevorzugte Sprache',
      'Chinese': 'Chinesisch',
      'English': 'Englisch',
      'Hindi': 'Hindi',
      'Spanish': 'Spanisch',
      'Arabic': 'Arabisch',
      'Malay': 'Malaiisch',
      'Russian': 'Russisch',
      'Bengali': 'Bengali',
      'Portuguese': 'Portugiesisch',
      'French': 'Französisch',
      'German': 'Deutsche',
      'find image': 'Bild suchen',
      'selected level': 'Ausgewählte Ebene',
      'level1': 'Stufe 1',
      'level2': 'Stufe 2',
      'level3': 'Stufe 3',
      'level4': 'Stufe 4',
      'level5': 'Stufe 5',
      'level6': 'Stufe 6',
      'level7': 'Stufe 7',
      'level8': 'Stufe 8',
      'level9': 'Stufe 9',
      'level10': 'Stufe 10',
      'level11': 'Stufe 11',
      'change level': 'Ebene wechseln',
      'summary': 'Zusammenfassung',
      'level1 name': 'Verstärkung',
      'level1 summary':
          'Die Hauptfunktion dieser Ebene besteht darin, den Benutzer zum Berühren des Bildschirms zu motivieren. Das Lernergebnis wird erreicht, wenn der Benutzer den Bildschirm unabhängig berührt, um ein Objekt anzufordern.',
      'Who does this level cater for': 'Who does this level cater for?',
      'level1 Who does this level cater for':
          'Ein Kind oder Erwachsener mit eingeschränkter Kommunikation. Die Hauptfunktion dieser Ebene besteht darin, den Benutzer zu ermutigen, von der APP / dem Gerät motiviert zu werden',
      'How do we achieve this?': 'Wie erreichen wir das?',
      'level1 How do we achieve this':
          'Der Elternteil / Lehrer / Spezialist muss sich des Verstärkers des Kindes bewusst sein. Eine Bewehrung ist ein Gegenstand oder ein Gegenstand, an dem der Benutzer Spaß hat oder von dem er besessen ist. Ein gutes Beispiel dafür wäre ein Lebensmittel wie Schokolade.',
      'select reinforcer': 'Bewehrung auswählen',
      'How do we get the user to touch the screen?':
          'Wie bringen wir den Benutzer dazu, den Bildschirm zu berühren?',
      'level1 How do we get the user to touch the screen':
          'Stufe 1 ist als ein Bildschirm / eine Schaltfläche eingerichtet, die spricht, sobald sie berührt wird. Am Beispiel von Schokolade sollte ein Elternteil / Lehrer / Spezialist die App so einrichten, dass das Schokoladenbild angezeigt wird. Der Elternteil / Lehrer / Spezialist MUSS während jeder Unterrichtsstunde mit vielen kleinen Schokoladenstücken vorbereitet sein, die dem Benutzer eine sofortige Belohnung bieten können. Denken Sie daran, es ist wichtig, Zeit für die Unterrichtsstunden vorzusehen, aber jeder Moment des Tages kann eine Gelegenheit zum Unterrichten sein. Bewahren Sie das iPad an einem Ort auf, an dem der Benutzer die Möglichkeit hat, es zu verwenden. \n\nWährend Ihrer Unterrichtsstunde \n1. Bieten Sie dem Benutzer ein kleines Stück Schokolade an. Es ist am besten, den Benutzer sitzen zu lassen, obwohl dies möglicherweise nicht immer möglich ist. \n2. Verwenden Sie "Hand über Hand", um den Benutzer zu ermutigen, den Bildschirm zu berühren. „Hand über Hand“ ist ein Unterrichtsansatz für autistische Kinder. Der Elternteil / Lehrer / Spezialist unterstützt den Benutzer, indem er ihn auffordert, die Taste zu drücken. Der Elternteil / Lehrer / Spezialist legt seine Hand auf die Hand des Benutzers und leitet sie zur ausgewählten Schaltfläche. * \n3. Sobald die APP spricht, muss der Elternteil / Lehrer / Spezialist dem Benutzer die Schokolade sofort geben. \n4. Dies sollte regelmäßig für einen Zeitraum von bis zu 5 Minuten wiederholt werden, sofern der Benutzer nicht frustriert ist. Versorge den Benutzer nicht mit Schokolade, bis der Knopf gedrückt wurde, unabhängig davon, wie frustriert sie sind. \n5. Wenn der Benutzer frustriert ist, geben Sie nicht auf. Dies ist ein langer Prozess, aber die langfristigen Gewinne bereiten den Benutzer auf das Leben vor. Beenden Sie diese Aufgabe und wiederholen Sie sie, wenn der Benutzer ruhig ist. \n\nWiederholen Sie die Schritte 1 bis 5 den ganzen Tag über in regelmäßigen Abständen. Viele Benutzer werden auf dieser Ebene sehr schnell erfolgreich sein, und andere werden viel harte Arbeit, Geduld und Mühe auf sich nehmen. \n\n* Die Kraft dieser Unterstützung sollte schrittweise verringert werden. Das vollständige Entfernen kann Monate dauern.',
      'How do you know ready for level 2':
          'Woher wissen Sie, dass der Benutzer für Level 2 bereit ist?',
      'level1 How do you know ready for level 2':
          'Der Benutzer wird die Notwendigkeit von "Hand über Hand" reduzieren, wenn Sie bemerken, dass Ihr Kind beginnt, diese APP zu verstehen, die ihm hilft, seinen Verstärker zu bekommen. Wenn der Benutzer den Knopf unabhängig und konsequent ohne Unterstützung durch die Eltern / Lehrer drückt, ist der Benutzer bereit für Stufe 2',
      'level2 name': 'Entscheidungen',
      'level2 summary':
          'Diese Stufe soll dem Benutzer beibringen, dass es mehr als eine Option für ein lohnendes Ergebnis gibt. \n\nLernergebnis: Der Benutzer kann beide Elemente konsistent und verständnisvoll anfordern.',
      'level2 Who does this level cater for':
          'Diese Ebene richtet sich an Benutzer, die auf Ebene 1 zugegriffen haben und nur einen minimalen Hand-über-Hand-Bedarf haben. Dem Benutzer werden zwei Optionen angeboten, die ihn dazu ermutigen, eine Wahl zu treffen.',
      'level2 How do we achieve this':
          'Der Elternteil / Lehrer / Spezialist muss sicherstellen, dass das zweite Bild, das dem Bildschirm hinzugefügt wird, eine zweite Verstärkung ist, z. B. Saft. \n\nDer Benutzer hat nun die Möglichkeit, zwei seiner Lieblingsartikel anzufordern. Dadurch wird seine Beziehung zur App aufgebaut.',
      'select second reinforcer': 'Wählen Sie den zweiten Bewehrer',
      'level2 How do we get the user to touch the screen':
          'Der Elternteil / Lehrer / Spezialist wendet die gleichen Strategien wie in Stufe 1 an. Zusammenfassend gesagt, müssen die beiden Elemente sofort verfügbar sein und dem Benutzer so bald wie möglich zur Verfügung gestellt werden. \n\nEs ist wichtig sicherzustellen, dass der Benutzer den richtigen Artikel erhält und sich des Unterschieds zwischen den beiden Bildern bewusst ist. Dem Benutzer sollte eines der Elemente angezeigt werden, und er muss dies genau und konsequent anfordern. Daten werden verfügbar sein, um Antworten hervorzuheben und Genauigkeit zu zeigen. \n\nDieses Level ist eines der schnellsten Levels, in denen der Benutzer Fortschritte erzielen kann, da der Benutzer bereits durch den Level-1-Verstärker motiviert sein sollte.',
      'How do you know ready for level 3':
          'Woher weißt du, dass der Benutzer für Level 3 bereit ist?',
      'level2 How do you know ready for level 3':
          'Der Benutzer wird ein besseres Vertrauen in die unabhängige Nutzung der App zeigen und es sollte nur ein begrenzter Bedarf an „Hand über Hand“ bestehen. \n\nWenn der Benutzer die Tasten unabhängig und konsequent drückt, mit begrenzter Unterstützung durch die Eltern / Lehrer / Spezialisten, ist dies ein Zeichen dafür, dass der Benutzer bereit für Stufe 3 ist.',
      'level3 name': 'Schlechte Entscheidungen',
      'level3 summary':
          'In diesem Stadium wird der Benutzer verstehen, dass die App ein Ergebnis liefert, das ihm / ihr Freude bereitet. Es ist wichtig, dass dieses Level bereitgestellt wird, da dieser Fortschritt den Benutzer lehrt, dass alle Entscheidungen nicht lohnend sind, sondern Kommunikation. Dieses Niveau wird in kurzer Zeit erreicht. \ n \ nLernergebnis: Der Benutzer sollte beobachtet werden, um Abneigung gegen das Empfangen der nicht bevorzugten Option zu zeigen. Der Benutzer wählt diese Option nicht mehr aus.',
      'level3 Who does this level cater for':
          'Diese Stufe richtet sich an Benutzer, die auf die Stufen 1 und 2 zugegriffen haben und nur eine minimale / null-Anforderung für "Hand über Hand" haben. Dem Benutzer wird eine dritte Option angeboten, die keine günstige Wahl ist.',
      'level3 How do we achieve this':
          'In diesem Entwicklungsstadium hat der Benutzer nun eine nicht bevorzugte Option. Der Elternteil / Lehrer / Spezialist muss sicherstellen, dass das dritte Bild, das dem Bildschirm hinzugefügt wird, ein nicht bevorzugter Gegenstand ist, z. B. eine Socke. \n\nDer Benutzer hat nun die Möglichkeit, zwei bevorzugte und eine nicht bevorzugte Option anzufordern.',
      'select third reinforcer': 'Wählen Sie das dritte Wort',
      'level3 How do we get the user to touch the screen':
          'Der Benutzer sollte nun von der App motiviert und fasziniert sein, die Bilder zu berühren. Die bisherigen Bilder haben ihnen Freude bereitet. Der Benutzer wird neugierig und sollte ein positives Ergebnis von dem nicht bevorzugten Artikel erhalten wollen. Sie / er sollte jedoch ohne Anregung durch die Eltern / Lehrer / Fachkräfte motiviert sein. Ist dies nicht der Fall, sollten die Eltern / Lehrer / Fachkräfte Strategien der Stufe 1 befolgen, um diese Interaktion zu fördern. \n\nWenn der Benutzer auswählt / berührt Wenn Sie eines der drei Bilder auswählen, erhalten Sie den Artikel sofort. Die ersten drei Ebenen dienen dazu, dem Benutzer das Anfordern eines Artikels beizubringen. Diese Ebene konsolidiert die Tatsache, dass nicht alle Entscheidungen angenehm sind, sondern Anforderungen. Der Benutzer wird nun lernen, zu berücksichtigen, dass Bilder, die er berührt, Objekte sind, die er erhält, unabhängig davon, ob sie ihm gefallen oder nicht.',
      'How do you know ready for level 4':
          'Woher weißt du, dass der Benutzer für Level 4 bereit ist?',
      'level3 How do you know ready for level 4':
          'Der Benutzer wird Enttäuschung zeigen, wenn er den nicht bevorzugten Artikel erhält, und wird weiterhin mit anderen angeforderten Artikeln zufrieden sein. Der Elternteil / Lehrer / Spezialist sollte weiterhin ein erhöhtes Vertrauen in die unabhängige Nutzung der App feststellen. \n\nWenn der Benutzer die Tasten unabhängig und konsequent ohne Unterstützung durch die Eltern / Lehrer / Fachkräfte drückt, ist der Benutzer bereit für Stufe 4. Die Daten bestätigen diese Beobachtungen. Der Benutzer sollte auch beobachtet werden, um Abneigung gegen den Empfang der nicht bevorzugten Option zu zeigen. Der Benutzer wählt diese Option nicht mehr aus.',
      'level4 name': 'Anrufbeantworter',
      'level4 summary':
          'Diese Ebene soll mit dem Aufbau der Sprachstruktur beginnen, die in den nächsten Ebenen verwendet wird. Die Belohnung für den Benutzer wird erst vergeben, wenn er das Bild ausgewählt und die Sprachbox berührt hat. \n\nLernergebnis: Der Benutzer wählt einen ausgewählten Gegenstand aus und wird verstehen, dass der Gegenstand erst dann bereitgestellt wird, wenn er es tut / er berührt die stimme box.',
      'level4 Who does this level cater for':
          'Diese Ebene richtet sich an Benutzer, die auf die Ebenen 1-3 zugegriffen haben und die App nun unabhängig mit minimaler / null Hand-über-Hand-Unterstützung verwenden. \n\nDiese Stufe ist eine der schwierigeren Stufen für Eltern / Lehrer / Fachkräfte und für den Benutzer eine frustrierende Stufe. Ziel dieser Stufe ist es, dem Benutzer die Verwendung einer Sprachbox beizubringen, die die Sprachentwicklung ermöglicht. In dieser Phase plant der Elternteil / Lehrer / Spezialist, die Sprache zu entwickeln, indem er den Benutzer auf die Verwendung der Zwei-Wort-Ebene vorbereitet, d. H. will Schokolade. Dieses Level braucht Zeit und Geduld. Möglicherweise müssen Sie für kurze Zeit wieder zu "Hand über Hand" zurückkehren.',
      'level4 How do we achieve this':
          'Zu diesem Zeitpunkt verbleibt der Bildschirm der Ebene 3 mit den gleichen drei Optionen, obwohl der Bildschirm jetzt einen langen Streifen am oberen Bildschirmrand aufweist. Dieser Streifen wird als "Sprachbox" bezeichnet. Wenn der Benutzer die üblichen Bilder berührt, wird das Wort nicht mehr sofort gesprochen. Es wird jetzt in der Sprachbox oben auf dem Bildschirm angezeigt. Der Benutzer muss jetzt die Sprachbox berühren, damit die ausgewählten Wörter gesprochen werden können.',
      'level4 How do we get the user to touch the screen':
          'Der Benutzer erhält keine sofortige Befriedigung mehr, wenn der Gegenstand angefordert wird. Sie / er muss aufgefordert werden, die Sprachbox zu berühren. Dies erfordert „Hand über Hand“, um den Benutzer anfangs zu unterrichten und zu zeigen, was erwartet wird. Alle Benutzer lernen dies mit einer anderen Geschwindigkeit. Die Eltern / Lehrer / Fachkräfte sollten das Hand-über-Hand-Verhältnis je nach Verständnis des Benutzers schrittweise verringern.',
      'How do you know ready for level 5':
          'Woher weißt du, dass der Benutzer für Level 5 bereit ist?',
      'level4 How do you know ready for level 5':
          'Der Benutzer wählt unabhängig oder mit Unterstützung von Hand über Hand das Objekt aus und berührt die Sprachbox. Die Daten zeigen eine hohe prozentuale Erfolgsquote.',
      'level5 name': 'Wortschatz aufbauen',
      'level 5 folders': 'Verhalten von Ordnern',
      'level 5 folder info':
          'Ordner werden in dieser Ebene nicht angezeigt. Dies ist beabsichtigt, damit der Benutzer nicht in andere Ordner navigiert und vom Ziel des Levels ablenkt',
      'level5 summary':
          'Diese Stufe ist der Beginn des Lehrprozesses mit dem primären Ziel, eine Sprache für den Benutzer zu erstellen. \n\nLernergebnis: Der Benutzer hat ein klares Verständnis von 6 oder mehr Wörtern in einem Ordner.',
      'level5 Who does this level cater for':
          'This level caters for Users who have accessed Levels 1-4. Users will generally be using the App independently at this stage although some may require ‘hand over hand’ support. \n\nThis level is the start of the teaching process with the primary aim being to build language for the User. The parent/teacher/specialist role becomes more important at this stage as new words should now be introduced to the User, and the parent/teacher/specialist must select words that would be important to the User. The words must also be within the same category ie. using the example of chocolate would require building language for snack items, and the snack items must be those preferred by the User. The categories have been pre-arranged into folders and the words can be made visible as required. If the words/items are not currently available on the folder, the parent/teacher/specialist can take a photo and add them in.\n\nAt this stage, the parent/teacher/specialist must follow the guidance that is provided in the teaching section regarding the use of videos, cards and items. This level takes time and a lot of patience. ‘Hand over hand’ may continue until the User builds his/her confidence.',
      'level5 How do we achieve this':
          'The Parent/Teacher/Specialist section within the App provides detail on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. \n\nThis section includes:\n1.	Continuing to request items\n2.	Matching pictures\n3.	Matching picture to object\n4.	Matching picture to item',
      'level5 How do we get the user to touch the screen':
          'This level requires the User to focus and remain seated to improve communication and build vocabulary. It is unlikely that the User will be willing to engage and therefore it is essential that the main reinforcer is re-introduced. The main reinforcer discussed as an example in the previous summaries was chocolate. In this case the chocolate must be readily available throughout these sessions as the User will be motivated to work if they are provided with a reward. \n\nInitially, the User should be rewarded with their reinforcer after EVERY successful item has been requested ie. when matching every item, the User should be rewarded with a small treat such as a third of a chocolate button. Gradually reduce the reinforcer treat as the User becomes more confident. In time, the User will no longer require a reinforcer. \n\For many this may require ‘hand over hand’ to initially teach the User and show what is expected. All Users will learn this at a different rate. The parent/teacher/specialist should gradually reduce the ‘hand over hand’ depending on the understanding of the User.',
      'How do you know ready for level 6':
          'How do you know the user is ready for level 6?',
      'level5 How do you know ready for level 6':
          'The User will have developed words within this category ie. snacks. This category will continue to be known as the ‘snack’ folder. When a folder contains 6 or more items the User is ready to progress to Level 6. The User would be expected to select items independently although some Users may still prefer ‘hand over hand’ support at this time. Data will continue to be available to show a high percentage success rate in identifying the chosen items. ',
      'level6 name': 'Creating folders',
      'level6 summary':
          'This Level allows Users to develop their language by increasing folders. Folders are created to allow Users to compartmentalize different topics ie. food, transport, clothes. \n\nLearning outcome: The User will show confidence in selecting items. They will be able to move between a minimum of three folders with ease.',
      'level6 Who does this level cater for':
          'This level differs from the others in that it caters for two groups:\n1.	Users who have accessed levels 1-5. These Users will be developing in confidence and most will be using the App independently. Some Users may still require extra support with ‘hand over hand’. Do not discourage this as all Users will develop at a different rate – as confidence grows, the need for support will reduce. \n2.	This would be the suggested stage to introduce the App to Users with limited/zero communication who are visual learners with moderate to good understanding. The parent/teacher/specialist should familiarize themselves with the teaching strategies employed in Levels 1-5 to promote maximum progress and understanding.\n\nThis Level allows Users to develop their language by increasing folders. Folders are created to allow Users to compartmentalize different topics ie. food, transport, clothes. \n\nThe Users who have accessed Levels 1-5 should be engaged and have a clear understanding of what is expected of them. This level allows the parent/teacher/specialist to add different folders to increase the language/speech opportunities. Consider this level as being similar language development for any individual learning a new language. Typical language development starts with one word ie. juice, cat, car. The words come from different folders. We, at Lucas Education, have created a template of folders that we believe are essential for day-to-day communication.',
      'level6 How do we achieve this':
          'One additional folder will be made available to the existing folder in Level 5. For new Users, two folders will be available. The parent/teacher/specialist selects a second folder which contains items that are motivating to the User. When data shows that the User has clearly understood 5 words, the App with allow the opportunity to unlock 5 more words within this folder as well as another folder. \n\nThis process will continue as your User continues to develop and grow. This is a natural process and the same process that all individuals go through when learning to speak and communicate. Level 6 is on-going learning and development.   \n\nThe Parent/Teacher/Specialist section within the App provides further detail on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. Games will be available in due course.\n\nThis section includes:\n1.	Continuing to request items\n2.	Matching pictures\n3.	Matching picture to object\n4.	Matching picture to item',
      'level6 How do we get the user to touch the screen':
          'This Level continues to require the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the program on the move. Examples of such opportunities are when seated in the car or maybe your child enjoys sitting in their pram.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be motivated to work if they are provided with a reward. It is important however to reduce the frequency of the reward. As the language develops, the reinforcer should be reduced and removed.  \n\nThis may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication.',
      'How do you know ready for level 7':
          'How do you know the user is ready for level 7?',
      'level6 How do you know ready for level 7':
          'The User will show confidence in selecting items. They will be able to move between a minimum of three folders with ease. Data will continue to be available to show a high percentage success rate in identifying the chosen items.',
      'level7 name': 'Sentence structure – part one',
      'level7 summary':
          'This Level allows Users to develop sentence structure by introducing a sentence starter. Folders are predesigned to predict possible sentence starters for each folder. \n\nLearning outcome: The User will show confidence in selecting the sentence starter followed by the chosen item. The words will be activated by pressing the voicebox.',
      'level7 Who does this level cater for':
          'This level caters for Users who have accessed Level 6.\n\nThis Level allows Users to develop sentence structure by introducing a sentence starter. Folders are predesigned to predict possible sentence starters for each folder. The option is also available to personalise words.',
      'level7 How do we achieve this':
          'In the previous section, typical language development was discussed. This section takes language development to the next level. Children move from one word level to two. We, at Lucas Education achieve this by introducing sentence starters which vary depending on the folder. Examples of this would be as follows:\n1.	Food folder – I want chocolate……I do not want chocolate.\n2.	Animal folder – I hear cat\n3.	Transport folder – I see car.\n\nSimilar to Level 4, the User may become frustrated during the initial stages of this Level as they are now expected to include a word prior to what has been expected of them in previous levels. For many reinforcers must be introduced again to ensure that the User remains motivated. \n\nAs with the previous folder the words/images will be released when data proves that the User is capable of understanding and consistently includes the sentence starter before requests. Level 7 is on-going learning and development.   \n\nThe Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources.',
      'level7 How do we get the user to touch the screen':
          'This Level also requires the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the programme on the move. Examples of such opportunities are when seated in the car or maybe your child enjoys sitting in their pram.\n\nOnce both icons, namely the sentence starter and the requested item, are appearing in the voice box, the User must touch the voice box and the App will say the sentence for example “I want chocolate” At this point the parent/teacher will give the User what he/she is requesting. The voice box should not be activated until an action and an image are added. Both icons must be spoken in the one voice box; they cannot be selected and spoken independently.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be more motivated to work if they are provided with a reward. This may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication. ',
      'How do you know ready for level 8':
          'How do you know the user is ready for level 8?',
      'level7 How do you know ready for level 8':
          'The User will show confidence in selecting the sentence starter followed by the chosen item. Data will continue to be available to show a high percentage success rate in identifying the chosen items and more sentence starters will be unlocked to develop language further.',
      'level8 name': 'Sentence structure – part two',
      'level8 summary':
          'This level caters for Users who have accessed Level 7.\n\nThis Level allows Users to develop sentence structure by including a sentence closer. Folders are predesigned to predict possible sentence closers for each folder. The option is also available to personalise words.',
      'level8 Who does this level cater for':
          'This level caters for Users who have accessed Level 7.\n\nThis Level allows Users to develop sentence structure by including a sentence closer. Folders are predesigned to predict possible sentence closers for each folder. The option is also available to personalise words.',
      'level8 How do we achieve this':
          'In Level 5, typical language development was promoted and in Level 6 the sentence starters were added. This Level progresses language development to the next level by closing the sentences. We, at Lucas Education achieve this by providing predicted sentence closers which vary depending on the folder. Examples of this would be as follows:\n1.	Food folder – I want chocolate please\n2.	Animal folder – I hear cat\n3.	Transport folder – I see car.\n\nThe final part of the sentences can or cannot be used in conjunction with the action and objects. For example in some cases, the closing part can be used alone eg. All done!\n\nSimilar to Levels 4 and 7, the User may become a little frustrated during the initial stages of this Level as they are now expected to include a word following what has been expected of them in previous levels. For many, reinforcers must be introduced again to ensure that the User remains motivated. \n\nAs with the previous folder the words/images will be released when data proves that the User is capable of understanding and consistently includes the sentence closer after requests. Level 8 is on-going learning and development.\n\The Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. ',
      'level8 How do we get the user to touch the screen':
          'This Level also requires the User to focus and remain seated to improve communication and build vocabulary. If this proves impossible, then use every opportunity to follow the programme on the move. Such opportunities could be made possible at snack time or perhaps when ordering food at a takeaway.\n\nWhen all three icons, namely the sentence starter, the requested item and the sentence closer, are appearing in the voice box, the User must touch the voice box and the App will say the sentence, for example “I want chocolate, please!”. At this point the parent/teacher will give the person what she/he is requesting. The voice box should not be activated until an action, an image and a closer are added. All three icons must be spoken in the one voice box; they cannot be selected and spoken independently.\n\nThe reinforcer must still be readily available throughout these sessions as the User will be more motivated to work if they are provided with a reward. This may require ‘hand over hand’ for some Users. Do not discourage the User if this is their preferred method of communication.',
      'How do you know ready for level 9':
          'How do you know the user is ready for level 9?',
      'level8 How do you know ready for level 9':
          'The User will show confidence in selecting the sentence starter followed by the chosen item and sentence closer. Data will continue to be available to show a high percentage success rate in identifying the chosen items and more sentence closers will be unlocked to develop language further. \n\nUsers at this Level are now capable of accessing Levels 9, 10 and 11. All three Levels are challenging and cater for higher functioning Users. These Levels do not have to taught in a sequential order, for example, the User may find difficulty in progressing through Levels 9 and 10, but may succeed in Level 11.',
      'level9 name': 'Grammar and developed literacy',
      'level9 summary':
          'This Level allows higher functioning Users the opportunity to focus on building sentence structure by developing literacy through use of conjunctions, connectives and pronouns.\nThis is an important building block to teaching the User how to read. \n\nTHIS IS ONE OF THE MORE CHALLENGING LEVELS.\n\nLearning outcome: The User will have the ability to communicate with confidence by linking words with conjunctives and using other literacy cues to develop language further.',
      'level9 Who does this level cater for':
          'This level caters for Users who have accessed Level 8.\n\nThis Level allows higher functioning Users the opportunity to focus on building sentence structure by developing literacy through use of conjunctions, connectives and pronouns.\n\nTHIS IS ONE OF THE MORE CHALLENGING LEVELS.',
      'level9 How do we achieve this':
          'The Parent/Teacher/Specialist section within the App provides further details/strategies on how to build language. Resources are provided or details are included to allow the parent/teacher/specialist to access further resources. \n\nData will also assist in gathering success criteria and in unlocking progressive language.',
      'level9 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program. ',
      'How do you know ready for level 10':
          'How do you know the user is ready for level 10?',
      'level9 How do you know ready for level 10':
          'The User is capable to access Level 10 directly from Level 8. All Levels can be used at the same time to develop language. Words will be unlocked when data dictates that the User is ready. ',
      'level10 name': 'Learning words',
      'level10 summary':
          'This Level allows higher functioning Users the opportunity to focus on learning words as opposed to pictures. This Level progresses by removing pictures and replacing them with the name/text of each object. This is the initial step in providing our non-verbal children with the opportunity to read.\n\nLearning outcome: The User will have the ability to communicate with the same confidence by using words as opposed to images.',
      'level10 Who does this level cater for':
          'This level caters for Users who have accessed Level 8 or 9.\n\nThis Level allows higher functioning Users the opportunity to focus on learning words as opposed to pictures. Users who require images should bypass this Level and access Level 10.',
      'level10 How do we achieve this':
          'The Parent/Teacher/Specialist will have an understanding of the favourite words selected by the User. Data will also assist in gathering such details. All words have been set up to show a large image with a small defined word below (show example). The Parent/Teacher/Specialist will now gradually reduce the size of the picture for the favourite words, whilst increasing the size of the word. With time the Parent/Teacher/Specialist will aim to remove the image and only provide the User with the word. Once again, experience and data will provide feedback on the understanding of the User and their readiness to remove images from other buttons.',
      'level10 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program. If they are unable to use the words when the images have been reduced, this is a sign that the User is not ready for this Level and it must be revisited at another stage.',
      'How do you know ready for level 11':
          'How do you know the user is ready for level 11?',
      'level10 How do you know ready for level 11':
          'The User will show confidence in selecting icons with words as opposed to images. Data will continue to be available to show a high percentage success rate in identifying the chosen items.',
      'level11 name': 'predictive images/writing',
      'level11 summary':
          'This Level allows Users the opportunity to communicate with greater speed by providing the User with the opportunity to select predicted images or words. \n\nLearning outcome: The User will have the ability to communicate with the same confidence although at a greater speed and fluency.',
      'level11 Who does this level cater for':
          'This level caters for Users who have accessed Level 8.\n\nThis Level allows Users the opportunity to communicate with greater speed. ',
      'level11 How do we achieve this':
          'This Level provides the User with the opportunity to select predicted images or words. The App will provide a list of actions to be selected by the user. Once an action is selected, the pictures/words to be shown will be presented depending on the frequency of usage for each word. The most used words will appear higher in the grid while less used words for that specific action will appear lower on the grid.',
      'level11 How do we get the user to touch the screen':
          'The User will be using the App independently at this stage of the program',
    },
  };

  static Future<Map<String, String>> getItems(List<String> items) async {
    String languageCode =
        await LocalPreferences.getString("languageCode", 'en');

    Map<String, String> result = Map<String, String>();
    if (!_localizedValues.containsKey(languageCode)) {
      for (int i = 0; i < items.length; i++) {
        result[items[i]] = "$languageCode not supported.";
      }
    }

    for (int i = 0; i < items.length; i++) {
      if (!_localizedValues[languageCode].containsKey(items[i])) {
        result[items[i]] =
            "'$items[i]' not found in '$languageCode'. Please contact support.";
      } else {
        result[items[i]] = _localizedValues[languageCode][items[i]];
      }
    }

    return result;
  }

  static Future<String> item(String item) async {
    String languageCode =
        await LocalPreferences.getString("languageCode", 'en');

    if (!_localizedValues.containsKey(languageCode))
      return languageCode +
          " not supported. Please change your language to any of the following: Mandarin, English, Hindi, Spanish, Arabic, Malay, Russian, Bengali, Portuguese, French or German";

    if (!_localizedValues[languageCode].containsKey(item))
      return "'" +
          item +
          "' not found in '" +
          languageCode +
          "'. Please contact support.";

    return _localizedValues[languageCode][item];
  }

  static Future<String> itemInL(String languageCode, String item) async {
    if (!_localizedValues.containsKey(languageCode))
      return languageCode + " not supported.";

    if (!_localizedValues[languageCode].containsKey(item))
      return "'" +
          item +
          "' not found in '" +
          languageCode +
          "'. Please contact support.";

    return _localizedValues[languageCode][item];
  }

  static Widget getLocalizedJoinedText(String item, String txt) {
    return FutureBuilder(
      future: L.item(item),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Text('');
          case ConnectionState.waiting:
            return new Center(child: new CircularProgressIndicator());
          case ConnectionState.active:
            return new Text('');
          case ConnectionState.done:
            if (snapshot.hasError) {
              return new Text(
                '${snapshot.error}',
                style: TextStyle(color: Colors.red),
              );
            } else {
              return Text(
                snapshot.data + txt,
                style: LocalPreferences.NormalTextStyle,
              );
            }
        }
        return Text("");
      },
    );
  }

  static Widget getLocalizedText(String item) {
    return FutureBuilder(
      future: L.item(item),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Text('');
          case ConnectionState.waiting:
            return new Center(child: new CircularProgressIndicator());
          case ConnectionState.active:
            return new Text('');
          case ConnectionState.done:
            if (snapshot.hasError) {
              return new Text(
                '${snapshot.error}',
                style: TextStyle(color: Colors.red),
              );
            } else {
              return Text(
                snapshot.data,
                style: LocalPreferences.NormalTextStyle,
              );
            }
        }
        return Text("");
      },
    );
  }

  static Widget getText(String item) {
    return FutureBuilder(
      future: L.item(item),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Text('');
          case ConnectionState.waiting:
            return new Center(child: new CircularProgressIndicator());
          case ConnectionState.active:
            return new Text('');
          case ConnectionState.done:
            if (snapshot.hasError) {
              return new Text(
                '${snapshot.error}',
                style: TextStyle(color: Colors.red),
              );
            } else {
              return Text(
                snapshot.data,
              );
            }
        }
        return Text("");
      },
    );
  }

  static Widget getUpperText(String item) {
    return FutureBuilder(
      future: L.item(item),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Text('');
          case ConnectionState.waiting:
            return new Center(child: new CircularProgressIndicator());
          case ConnectionState.active:
            return new Text('');
          case ConnectionState.done:
            if (snapshot.hasError) {
              return new Text(
                '${snapshot.error}',
                style: TextStyle(color: Colors.red),
              );
            } else {
              return Text(snapshot.data.toUpperCase());
            }
        }
        return Text("");
      },
    );
  }

  static Widget getAppBarLocalizedText(String item) {
    return FutureBuilder(
      future: L.item(item),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Text('');
          case ConnectionState.waiting:
            return new Center(child: new CircularProgressIndicator());
          case ConnectionState.active:
            return new Text('');
          case ConnectionState.done:
            if (snapshot.hasError) {
              return new Text(
                '${snapshot.error}',
                style: TextStyle(color: Colors.red),
              );
            } else {
              return Text(snapshot.data);
            }
        }
        return Text("");
      },
    );
  }

  static Map getLanguageCountryCode() {
    Map<String, String> languageCountryCodes = new Map();
    languageCountryCodes['ar'] = 'Arabic';
    languageCountryCodes['ar-AE'] = 'Arabic (U.A.E.)';
    languageCountryCodes['ar-BH'] = 'Arabic (Bahrain)';
    languageCountryCodes['ar-DZ'] = 'Arabic (Algeria)';
    languageCountryCodes['ar-EG'] = 'Arabic (Egypt)';
    languageCountryCodes['ar-IQ'] = 'Arabic (Iraq)';
    languageCountryCodes['ar-JO'] = 'Arabic (Jordan)';
    languageCountryCodes['ar-KW'] = 'Arabic (Kuwait)';
    languageCountryCodes['ar-LB'] = 'Arabic (Lebanon)';
    languageCountryCodes['ar-LY'] = 'Arabic (Libya)';
    languageCountryCodes['ar-MA'] = 'Arabic (Morocco)';
    languageCountryCodes['ar-OM'] = 'Arabic (Oman)';
    languageCountryCodes['ar-QA'] = 'Arabic (Qatar)';
    languageCountryCodes['ar-SA'] = 'Arabic (Saudi Arabia)';
    languageCountryCodes['ar-SY'] = 'Arabic (Syria)';
    languageCountryCodes['ar-TN'] = 'Arabic (Tunisia)';
    languageCountryCodes['ar-YE'] = 'Arabic (Yemen)';
    languageCountryCodes['de'] = 'German';
    languageCountryCodes['de-AT'] = 'German (Austria)';
    languageCountryCodes['de-CH'] = 'German (Switzerland)';
    languageCountryCodes['de-DE'] = 'German (Germany)';
    languageCountryCodes['de-LI'] = 'German (Liechtenstein)';
    languageCountryCodes['de-LU'] = 'German (Luxembourg)';
    languageCountryCodes['zh'] = 'Chinese';
    languageCountryCodes['zh-CN'] = 'Chinese (S)';
    languageCountryCodes['zh-HK'] = 'Chinese (Hong Kong)';
    languageCountryCodes['zh-MO'] = 'Chinese (Macau)';
    languageCountryCodes['zh-SG'] = 'Chinese (Singapore)';
    languageCountryCodes['zh-TW'] = 'Chinese (T)';
    languageCountryCodes['en'] = 'English';
    languageCountryCodes['en-AU'] = 'English (Australia)';
    languageCountryCodes['en-BZ'] = 'English (Belize)';
    languageCountryCodes['en-CA'] = 'English (Canada)';
    languageCountryCodes['en-CB'] = 'English (Caribbean)';
    languageCountryCodes['en-GB'] = 'English (United Kingdom)';
    languageCountryCodes['en-IE'] = 'English (Ireland)';
    languageCountryCodes['en-JM'] = 'English (Jamaica)';
    languageCountryCodes['en-NZ'] = 'English (New Zealand)';
    languageCountryCodes['en-PH'] = 'English (Republic of the Philippines)';
    languageCountryCodes['en-TT'] = 'English (Trinidad and Tobago)';
    languageCountryCodes['en-US'] = 'English (United States)';
    languageCountryCodes['en-ZA'] = 'English (South Africa)';
    languageCountryCodes['en-ZW'] = 'English (Zimbabwe)';
    languageCountryCodes['hi'] = 'Hindi';
    languageCountryCodes['hi-IN'] = 'Hindi (India)';
    languageCountryCodes['es'] = 'Spanish';
    languageCountryCodes['es-AR'] = 'Spanish (Argentina)';
    languageCountryCodes['es-BO'] = 'Spanish (Bolivia)';
    languageCountryCodes['es-CL'] = 'Spanish (Chile)';
    languageCountryCodes['es-CO'] = 'Spanish (Colombia)';
    languageCountryCodes['es-CR'] = 'Spanish (Costa Rica)';
    languageCountryCodes['es-DO'] = 'Spanish (Dominican Republic)';
    languageCountryCodes['es-EC'] = 'Spanish (Ecuador)';
    languageCountryCodes['es-ES'] = 'Spanish (Castilian)';
    languageCountryCodes['es-ES'] = 'Spanish (Spain)';
    languageCountryCodes['es-GT'] = 'Spanish (Guatemala)';
    languageCountryCodes['es-HN'] = 'Spanish (Honduras)';
    languageCountryCodes['es-MX'] = 'Spanish (Mexico)';
    languageCountryCodes['es-NI'] = 'Spanish (Nicaragua)';
    languageCountryCodes['es-PA'] = 'Spanish (Panama)';
    languageCountryCodes['es-PE'] = 'Spanish (Peru)';
    languageCountryCodes['es-PR'] = 'Spanish (Puerto Rico)';
    languageCountryCodes['es-PY'] = 'Spanish (Paraguay)';
    languageCountryCodes['es-SV'] = 'Spanish (El Salvador)';
    languageCountryCodes['es-UY'] = 'Spanish (Uruguay)';
    languageCountryCodes['es-VE'] = 'Spanish (Venezuela)';
    languageCountryCodes['ms'] = 'Malay';
    languageCountryCodes['ms-BN'] = 'Malay (Brunei Darussalam)';
    languageCountryCodes['ms-MY'] = 'Malay (Malaysia)';
    languageCountryCodes['ru'] = 'Russian';
    languageCountryCodes['ru-RU'] = 'Russian (Russia)';
    languageCountryCodes['bn'] = 'Bengali';
    languageCountryCodes['pt'] = 'Portuguese';
    languageCountryCodes['pt-BR'] = 'Portuguese (Brazil)';
    languageCountryCodes['pt-PT'] = 'Portuguese (Portugal)';
    languageCountryCodes['fr'] = 'French';
    languageCountryCodes['fr-BE'] = 'French (Belgium)';
    languageCountryCodes['fr-CA'] = 'French (Canada)';
    languageCountryCodes['fr-CH'] = 'French (Switzerland)';
    languageCountryCodes['fr-FR'] = 'French (France)';
    languageCountryCodes['fr-LU'] = 'French (Luxembourg)';
    languageCountryCodes['fr-MC'] = 'French (Principality of Monaco)';
    languageCountryCodes['de'] = 'German';
    languageCountryCodes['de-AT'] = 'German (Austria)';
    languageCountryCodes['de-CH'] = 'German (Switzerland)';
    languageCountryCodes['de-DE'] = 'German (Germany)';
    languageCountryCodes['de-LI'] = 'German (Liechtenstein)';
    languageCountryCodes['de-LU'] = 'German (Luxembourg)';

    return languageCountryCodes;
  }

  static Future<Map<String, String>> getPossibleLanguageCountryCodes() async {
    FlutterTts flutterTts = new FlutterTts();

    Map<String, String> languageCountryCodes = L.getLanguageCountryCode();
    Map<String, String> possibleLanguageCountryCodes = new Map();

    String languageCode =
        await LocalPreferences.getString("languageCode", "en");

    languageCountryCodes.forEach((k, v) async {
      if (k.startsWith(languageCode)) {
        bool isLanguageAvailable = await flutterTts.isLanguageAvailable(k);
        if (isLanguageAvailable) {
          possibleLanguageCountryCodes[k] = v;
        }
      }
    });

    return possibleLanguageCountryCodes;
  }

  static void selectFirstAvailableVoice() async {
    FlutterTts flutterTts = new FlutterTts();

    Map<String, String> languageCountryCodes = L.getLanguageCountryCode();

    String languageCode =
        await LocalPreferences.getString("languageCode", "en");

    languageCountryCodes.forEach((k, v) async {
      if (k.startsWith(languageCode)) {
        bool isLanguageAvailable = await flutterTts.isLanguageAvailable(k);
        if (isLanguageAvailable) {
          String languageCode =
              await LocalPreferences.getString("languageCountry", '');
          if (languageCode.isEmpty) {
            await LocalPreferences.setString("languageCountry", k);
          }
        }
      }
    });
  }

  static Widget getLocalizedTitleText(String item) {
    return FutureBuilder(
      future: L.item(item),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Text('');
          case ConnectionState.waiting:
            return new Center(child: new CircularProgressIndicator());
          case ConnectionState.active:
            return new Text('');
          case ConnectionState.done:
            if (snapshot.hasError) {
              return new Text(
                '${snapshot.error}',
                style: TextStyle(color: Colors.red),
              );
            } else {
              return Text(
                snapshot.data,
                style: LocalPreferences.TitleTextStyle,
              );
            }
        }
        return Text("");
      },
    );
  }
}
