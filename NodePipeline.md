# Node Pipeline for Node Graph
 
A node graph is commonly represented as a kind of flowchart with a Directed Acylic Graph (DAG) in most digital compositing software as shown below:
  
     Read media  Read media
     |           |     
     V           V     
     Premult     Color Correction
     |           |
     |           V
     |           Transform
     |           |
     |           V
     |           Gaussian Blur
     |           |
     V           V
         Merge
           |
           V
         Viewer
   
On a small screen mobile device, the DAG could be decomposed into multiple series of nodes shown below (from here we will refer this as the Node Pipeline).

For example, the node graph above can be represented as below:
  
     Read media
     |                
     V               
     Premult     

  
     Read media
     |              
     V             
     Color Correction
     |           
     V
     Transform
     |           
     V          
     Gaussian Blur      
     
     
     Merge
     |
     V
     Viewer
  
Notice the break from the first series after the Premult node and the second break after the Gaussian Blur node.

We can visualize how the pipeline can appear as a simple list on a mobile device below.
  
    1. Read media         >
    2. Premult            >
  
    3. Read media         >
    4. Color Correction   >
    5. Transform          >
    6. Blur               >
  
    7. Merge 2,6          >
    8. Viewer             >
  
The lines joining the nodes could be further represented by listing the input nodes used, similar to using a spreadsheet formula (e.g =SUM(A1,A2)).
  
Input referencing previous nodes below:
  
    1. Read media       (input none)  >
    2. Premult          (input 1)     >
  
    3. Read media       (input none)  >
    4. Color Correction (input 3)     >
    5. Transform        (input 4)     >
    6. Gaussian Blur    (input 5)     >
  
    7. Merge            (input 2,6)   >
    8. Viewer           (input 7)     >
  
Simplfying it further
  
    1. Read media       (none)  >
    2. Premult          (1)     >
  
    3. Read media       (none)  >
    4. Color Correction (3)     >
    5. Transform        (4)     >
    6. Gaussian Blur    (5)     >
  
    7. Merge            (2,6)   >
    8. Viewer           (7)     >
  
First, this will require a slight shift in thinking, especially by one familiar to a desktop node-based tool. Instead of three parallel series of nodes, it is now three sequence or series of nodes in a Node Pipeline.
 
Interestingly, the first thing to note is, mathematically, a DAG can be decomposed to the above with any loss of information. This means a node graph represented with a Node Pipeline can be as flexible as a flow chart like node graph.
  
Secondly, it the contextual overload of a user of frequently panning a flow-chart-like node graph on a small screen is significantly reduced. A Node Pipeline is easy to navigate as one can quickly scroll up and down of the list. Tapping on a node can bring up a screen can enable a change in the node properties.
 
Thirdly, the Node Pipeline is 'not too far away' from a metaphor that a desktop node-based tool user is very familiar with, the 'Link To' capability. Below, the merge node is linking to node 2 and node 6 and using them as input nodes.
 
 7. Merge            (2,6)   >
 
The above approach leads to other interesting productivity gains in compositing on a mobile device. Please check out my second related article on Node Pipeline, specifically on:
 
  * Auto Chaining
  * Reverse Compositing
  * Viewer Cycling
  * DAG Graph Generation/Import DAG
 
In it, I will address on how to specifically join nodes, or link node properties, or setting the Viewer.

### Feedback
 
Whether a Node Pipeline is suited for representing a node graph on a small screen ultimately requires feedback and testing by many. If your daily work involves working in a related field, I would appreciate if you could provide your feedback to me on my Github repository. This repository also hosts an open-source project that implements the Node Pipeline. I also have an app in Apple App Store, designed for the iPhone, for those that want to test out the user interface directly.

### Open User Interface

The ideas and user interface proposed here are from some of my random thoughts and not protected by any patents nor IP, or at least as far as I know. Please feel free to use them in any way you deem fit (but of course at your own risk), both commercially and non-commercially.
