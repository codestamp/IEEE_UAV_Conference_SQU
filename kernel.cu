// A C / C++ program for Prim's Minimum 
// Spanning Tree (MST) algorithm. The program is 
// for adjacency matrix representation of the graph 
#include <stdio.h> 
#include <limits.h> 
#include<stdbool.h> 
#include <cstdlib>
#include <ctime>
#include <algorithm>

// Number of vertices in the graph 
#define V 26 
#define K 4
// A utility function to find the vertex with 
// minimum key value, from the set of vertices 
// not yet included in MST 
int minKey(int key[], bool mstSet[])
{
	// Initialize min value 
	int min = INT_MAX, min_index=0;

	for (int v = 0; v < V; v++)
		if (mstSet[v] == false && key[v] < min)
			min = key[v], min_index = v;

	return min_index;
}

/*
void sortGraph(int graph[V][V]) 
{
	for (int xcord = 0; xcord<V; xcord++){
		for (int ycord = xcord + 1; ycord<V; ycord++){
			if (graph[xcord][0]>graph[ycord][0]){

				int temp = graph[xcord][1];
				int temp2 = graph[xcord][0];
				graph[xcord][0] = graph[ycord][0];
				graph[xcord][1] = graph[ycord][1];
				graph[ycord][0] = temp2;
				graph[ycord][1] = temp;
			}
		}
	}
}

// A utility function to print the 
// constructed MST stored in parent[] 
void printMST(int parent[], int n, int graph[V][V])
{
	//sortGraph(graph);
	printf("  Edge \t\tWeight\n");
	for (int i = 1; i < V; i++)
		printf("%2d - %2d \t%3d \n", parent[i], i, graph[i][parent[i]]);
}
*/
void kMstClusterPrint(int parent[], int n, int graph[V][V]) {
	//k number of clusters, let k=5
	int k[5] = { 0 };
	//int clusterGraph[k][V][V];

	//select random edges for removal
	srand(time(NULL));
	for (int i = 0; i < 5; i++) {
		k[i] = (int)rand() % 26;
		printf("%d\t", k[i]);
	}
	printf("\n\n");
	bool flag = false;
	for (int i = 1; i < V; i++) {
		for (int j = 0; j < 5; j++) 
		{
			if (i == k[j]) flag = true;
		}
		if (!flag) 
			printf("%2d - %2d \t%3d \n", parent[i], i, graph[i][parent[i]]);
		flag = false;
	}
}

// Function to construct and print MST for 
// a graph represented using adjacency 
// matrix representation 
void primMST(int graph[V][V])
{
	// Array to store constructed MST 
	int parent[V];
	// Key values used to pick minimum weight edge in cut 
	int key[V];
	// To represent set of vertices not yet included in MST 
	bool mstSet[V];

	// Initialize all keys as INFINITE 
	for (int i = 0; i < V; i++)
		key[i] = INT_MAX, mstSet[i] = false;

	// Always include first 1st vertex in MST. 
	// Make key 0 so that this vertex is picked as first vertex. 
	key[0] = 0;
	parent[0] = -1; // First node is always root of MST 

	// The MST will have V vertices 
	for (int count = 0; count < V - 1; count++)
	{
		// Pick the minimum key vertex from the 
		// set of vertices not yet included in MST 
		int u = minKey(key, mstSet);

		// Add the picked vertex to the MST Set 
		mstSet[u] = true;

		// Update key value and parent index of 
		// the adjacent vertices of the picked vertex. 
		// Consider only those vertices which are not 
		// yet included in MST 
		for (int v = 0; v < V; v++)

			// graph[u][v] is non zero only for adjacent vertices of m 
			// mstSet[v] is false for vertices not yet included in MST 
			// Update the key only if graph[u][v] is smaller than key[v] 
			if (graph[u][v] && mstSet[v] == false && graph[u][v] < key[v])
				parent[v] = u, key[v] = graph[u][v];
	}

	// print the constructed MST 
	kMstClusterPrint(parent, V, graph);
	//printMST(parent, V, graph);
}


// driver program to test above function 
int main()
{
	/* Let us create the following graph
	2 3
	(0)--(1)--(2)
	| / \ |
	6| 8/ \5 |7
	| /	 \ |
	(3)-------(4)
	9		 */
	int graph[V][V] = {
		{ 0, 4, 0, 0, 10, 0, 0, 0, 0, 9, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },//a
		{ 4, 0, 29, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },//b
		{ 0, 29, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },//c
		{ 0, 0, 8, 0, 6, 0, 0, 0, 0, 0, 17, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },//d
		{ 10, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },//e
		{ 0, 0, 0, 0, 9, 0, 24, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },//f
		{ 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },//g
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },//h
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },//i
		{ 9, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0 },//j
		{ 0, 11, 0, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0 },//k
		{ 10, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 27, 0, 0, 0, 0, 0, 0, 0 },//l
		{ 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0 },//m
		{ 0, 0, 0, 0, 0, 12, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0 },//n
		{ 0, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 17, 25, 0, 0 },//o
		{ 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },//p
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 26, 0, 0, 0, 0, 0, 0, 0, 19, 0, 0, 0, 0, 0, 0, 0, 9 },//q
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 19, 0, 24, 0, 0, 0, 0, 0, 0, 16 },//r
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27, 0, 0, 0, 0, 0, 24, 0, 0, 13, 0, 0, 0, 0, 0 },//s
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13 },//t
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 13, 0, 0, 10, 0, 0, 0, 0 },//u
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 4, 0, 0, 23 },//v
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0 },//w
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },//x
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30 },//y
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 16, 0, 13, 0, 23, 0, 0, 30, 0 }//z
	};
		
	// Print the solution 
	primMST(graph);

	return 0;
}
