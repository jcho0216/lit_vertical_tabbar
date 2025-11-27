# lit_vertical_tabbar

Widget that provides automated TabBar changes when ListView is scrolled.

### Demo

<p align="center" width="100%">
<video src="https://github.com/user-attachments/assets/49bc6755-4d2c-4e3a-90b3-e4e28f853abc" width="80%" controls></video>
</p>
<br/>

## Usage
```
LitVerticalTabBar(
  backgroundColor: Colors.black87,
  padding: const EdgeInsets.symmetric(vertical: 24),
  moveTabToLastIndexOnScrollEnd: true,
  children: [LitElementModel(tabName: "tab1", child: ChildWidget())],
  divider: Divider(),
)
```
