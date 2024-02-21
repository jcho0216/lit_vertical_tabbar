# sliver_vertical_tabbar

## Getting Started

### Widget that Automatically controlls TabBar index on ListView scroll.
 
This widget is using ListView to render items for better performance.
  
<br/>

https://github.com/jcho0216/sliver_vertical_tabbar/assets/67269455/63a96a61-db77-4d35-a4d0-077670e3cd4d

<br/>

## Usage
```
SliverVerticalTabBar(
  backgroundColor: Colors.black87,
  padding: const EdgeInsets.symmetric(vertical: 24),
  moveTabToLastIndexOnScrollEnd: true,

  /// tabs length must be the same length as children length
  tabs: [...],
  children: [...],
  divider: Divider(),
)
```

Feel free to request for a feature :)
