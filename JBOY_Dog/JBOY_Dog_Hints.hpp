   //Add this into description.ext:  include "JBOY_Dog\JBOY_Dog_Hints.hpp"
   class JBOYDogCommandHints
   {
       displayName = "Dog Menu";
       class MenuTKey
       {
           arguments[] = {};
           displayName = "Use T Key for dog menu";
           description = "";
           tip = "Press T key for dog menu.  Then click on any command option.  Escape key hides menu.";
       };
       class CommandHeel
       {
           arguments[] = {};
           displayName = "Heel Command";
           description = "Command Dog to Heel";
           tip = "Press T key for dog menu.  Then click on Heel command.";
       };
       class CommandTrack
       {
           arguments[] = {};
           displayName = "Track Command";
           description = "Command Dog to Track a scent trail.";
           tip = "The dog runs in circles and barks when he has found a scent trail.  Choose Track command to get dog to follow that trail.";
       };
       class ResumeTracking
       {
       
           arguments[] = {};
           displayName = "Resume tracking";
           description = "Start tracking again";
           tip = "Choose the Track command again for dog to resume tracking of current known trail.";
       };
       class SwimHint
       {
           arguments[] = {};
           displayName = "Dog swimming";
           description = "Get dog to swim";
           tip = "The dog will only swim if he is following you.  Choose heel command, and then walk or swim accross water.  The dog will follow you.";
       };
       class EndOfTrail
       {
           arguments[] = {};
           displayName = "End of Scent Trail";
           description = "End of Scent Trail Found";
           tip = "The dog has found the end of the scent trail.";
       };
       class HealDog
       {
           arguments[] = {};
           displayName = "Heal Dog";
           description = "Heal Dog";
           tip = "You know the dog is hit when he cries repeatedly.  To heal dog: stop him, go near him, and use heal action.  You must have a medkit.";
       };
   };