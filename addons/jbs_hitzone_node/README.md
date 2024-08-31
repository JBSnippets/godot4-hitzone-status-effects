# <img src="https://raw.githubusercontent.com/JBSnippets/godot4-hitzone-status-effects/main/jbs_hitzone_node_128.png" width="32" height="32" /> Hit Zone & Status Effects ~ Godot 4+
A custom Godot 4+ node used to detect a hit from an attack and creates a series of status/effects on the target.

This custom node can be used to detect a hit from an attack by monitoring collisions when a node body enters the selected Area2D. After calling the `hit_body` function either manually or automatically when collision is detected, status/effects are created in the target node body.

## 🧬 Features
- Automatically create statuses and/or effects when node body hits an Area2D.
- Easily add a dictionary of status/effect resistances.
- Includes `Damage`, `Heal` and `Knockback` effects.
- Built to integrate with [JBS Health Node](https://github.com/JBSnippets/godot4-health).
- Signals are emitted before and after status/effect application.
- Extend and create your own status and effect!

## 💽 Supported Versions
<img src="https://img.shields.io/badge/Godot-v4.1.1-%23478cbf?logo=godot-engine&logoColor=cyian&color=blue"> <img src="https://img.shields.io/badge/Godot-v4.1.2-%23478cbf?logo=godot-engine&logoColor=cyian&color=blue"> <img src="https://img.shields.io/badge/Godot-v4.1.3-%23478cbf?logo=godot-engine&logoColor=cyian&color=blue"> <img src="https://img.shields.io/badge/Godot-v4.1.4-%23478cbf?logo=godot-engine&logoColor=cyian&color=blue"> <img src="https://img.shields.io/badge/Godot-v4.2.0-%23478cbf?logo=godot-engine&logoColor=cyian&color=blue"> <img src="https://img.shields.io/badge/Godot-v4.2.1-%23478cbf?logo=godot-engine&logoColor=cyian&color=blue"> <img src="https://img.shields.io/badge/Godot-v4.2.2-%23478cbf?logo=godot-engine&logoColor=cyian&color=blue"> <img src="https://img.shields.io/badge/Godot-v4.3-%23478cbf?logo=godot-engine&logoColor=cyian&color=blue">

## 📥 Installing the Plugin

### Install using Godot's AssetLib

1. Go to the `AssetLib` in the Godot Editor.
1. Type "hitzone" to search for the `HitZone` node.
1. Select the asset (by JBSnippets 😊) and click Download.

### Install with examples

- Download as a ZIP file from this repository or
- Clone this repository

## 🚀 How to add the node
Once this plugin is enabled, you can add the `HitZone` node as a child of another node, like a StaticBody such as a weapon, trap, or projectile, to utilize its features.

1. Right-click on a node or press Ctrl+A.

![Add Node](https://github.com/JBSnippets/godot4-hitzone-status-effects/blob/main/assets/add_node0.png)

2. Type "hitzone" on the Search textbox of the Create New Node form to filter the node list and easily find the `HitZone` node.

![Add Node](https://github.com/JBSnippets/godot4-hitzone-status-effects/blob/main/assets/add_node1.png)

3. Double-click the `HitZone` node to add as a child of the node.

![Add Node](https://github.com/JBSnippets/godot4-hitzone-status-effects/blob/main/assets/add_node2.png)

## 📺 Video on How to use the plugin.
[![Watch the video](https://github.com/JBSnippets/godot4-hitzone-status-effects/blob/main/assets/JBSnippets%20YT%20Thumbnail%205.png)](https://youtu.be/sO-GPKkjZOE)

## 📡 More Plugins!
Head on over to my website at [https://plugins.jbsnippets.com](https://plugins.jbsnippets.com) to read more about this plugin and other plugins that I've been creating during my game development journey with Godot!
