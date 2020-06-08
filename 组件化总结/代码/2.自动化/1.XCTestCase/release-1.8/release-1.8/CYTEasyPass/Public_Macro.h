#ifndef Public_Macro_h  
#define Public_Macro_h


//坐标
#define BRect(x,y,w,h) CGRectMake(x, y, w, h)
#define BSize(w,h) CGSizeMake(w, h)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)  
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)  


//----------------------颜色类---------------------------  
// rgb颜色转换（16进制->10进制）  
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]  

  
//带有RGBA的颜色设置  
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]  
  
// 获取RGB颜色  
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]  
#define RGB(r,g,b) RGBA(r,g,b,1.0f)  
  
//背景色  
#define BACKGROUND_COLOR [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]  
  
//清除背景色  
#define CLEARCOLOR [UIColor clearColor]  
  
#pragma mark - color functions  
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]  
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]  
  

//设置View的tag属性  
#define VIEWWITHTAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG]
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)  
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)  


#define ESWeak(var, weakVar) __weak __typeof(&*var) weakVar = var
#define ESStrong_DoNotCheckNil(weakVar, _var) __typeof(&*weakVar) _var = weakVar
#define ESStrong(weakVar, _var) ESStrong_DoNotCheckNil(weakVar, _var); if (!_var) return;

/** defines a weak `self` named `__weakSelf` */
#define ESWeakSelf      ESWeak(self, __weakSelf);
/** defines a strong `self` named `_self` from `__weakSelf` */
#define ESStrongSelf    ESStrong(__weakSelf, _self);


#endif
