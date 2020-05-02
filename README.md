# Survival-Game
This is a survival game in development, the main idea is to develop basic features that other survival games have. I am using
 the godot engine. I had previously tried to make a survival game, but due to lack of time i had to give up. You can follow the previous try [here](https://github.com/Bufige/Survival-Game)

# What is currently done or what will be done:
You can follow the progress of the game [here](https://www.notion.so/Survival-Game-using-godot-ac1b11ab7b5d466ab53b6d844f0274bd). There contains more info about the project, there are links that you can watch me code or follow the ideas of what is to be implemented. I try to livestream them.

# Why the art of the game is so poor? 
I have no skills to develop the game art, so those assets that i use are free and available in the internet. In case you want to help me with the art, try to contact me.

# How to run this thing?

Just clone this project or download and open it with the godot engine. Currently using godot 3.2.

# How to add new item?
You need to make the item as a new scene. First you create a spatial object to hold the 3d object, then you add a meshinstance and add as mesh the model or you just drop the model into the spartial and godot will try to create it, it depends in which format it is.  Place the model inside models folder and the new scene object in the prefabs.


# How to make the item interactable?

Once you created the scene from the model, you make a copy of it, you go to the scene and create a CollisionShape for the item, make it boxshape, it's less computer expensive. Set the meshinstance as child of the collisionshape and reset its transforms. After that, you create a 3drigidbody and set as parent of the collisionshape. Now the item can interact with the enviroment, if you want the item to be pickable, add the script "Interactable" to the ridibody and set his collision layer to 2, also the set item name in the script to be what you will provide in itemsData.gd. 

Now you need to go to itemsData.gd and provide more details about the item, where is located those prefabs,  id, type of item and name of the item. Once this is done, the item is fully integrated into the game.