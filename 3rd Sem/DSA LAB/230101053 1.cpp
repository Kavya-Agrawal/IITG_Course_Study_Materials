#include <bits/stdc++.h>
#include <vector>
#include <string>
#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>
#include <functional> // for less
using namespace std;
using namespace __gnu_pbds;
typedef long long ll;
typedef unsigned long long ull;
typedef pair<ll, ll> pll;
typedef pair<int, int> pii;
typedef pair<int, ll> pil;
typedef pair<ll, int> pli;
typedef vector<ll> vl;
typedef vector<int> vi;
#define p(g , h) pair<g , h> 
#define v(g) vector<g> 
const int MOD = 1e9 + 7;
#define all(v) v.begin(), v.end()
#define rall(v) v.rbegin(), v.rend()
template<class T> bool ckmax(T& a, const T& b) { return a < b ? a = b, 1 : 0;} 
template<class T> bool ckmin(T& a, const T& b) { return a > b ? a = b, 1 : 0;} 
#define ct cout << 
#define cten cout << endl;
#define ctiam cout << " It's_easier!!" << " \n " ;
#define ctafter  << " you_got_me!"  
#define ci cin >> 
#define blk  << " " << 
#define cty cout << "YES" << '\n';
#define ctn cout << "NO" << '\n';
#define en  << endl
#define cin(a) for (auto &&var  : a) { ci var; }
template<typename T, typename... Args>
void cnv(T& first, Args&... args) { std::cin >> first; (std::cin >> ... >> args); } 
#define cout(a) for (auto &&var  : a) { ct var << " "; } cten 
#define cinhf(a , n) for( ll i = 0 ; i < n ; i++ ) { ci a[i];} 
#define couthf(a , n) for( ll i = 0 ; i < n ; i++ ) { ct a[i] << " ";} cten 
#define cinhf2(a , n , m) for( ll i = 0 ; i < n ; i++ )  {for( ll j = 0; j < m; j++ ) { ci a[i][j];} } 
#define couthf2(a , n , m) for( ll i = 0 ; i < n ; i++ )  {for( ll j = 0; j < m; j++ ) { ct a[i][j] << " ";} cten } cten 
#define cin2(a) for( auto &&var1 : a)  for( auto &&var2 : var1)  ci var2; 
#define cout2(a) for( auto &&var1 : a)  {for( auto &&var2 : var1)  {ct var2 << " ";} cten } cten 
typedef tree<int, null_type, less<int>, rb_tree_tag, 
 tree_order_statistics_node_update> ordered_set;
const int maxn = 200000 + 5;

class Errors {
private:
   string errors;
public:
   Errors(const string& message) : errors(message) {}
   string showError() const {
      return errors;
   }
};

template <typename T>
class Node
{
private:
   
public:
   T data;
   Node <T> * left;
   Node <T> * right;
   Node(T a){
      data = a;
      left = nullptr;
      right = nullptr;
   }
};

template <typename T>
class BST
{
private:
   Node <T> * root;

   // Node<T> * insert_node( Node <T> * node,  T key) {
   //    Node* node = root;
   //    if (node == NULL) 
   //       return new Node(key);    
      
   //    if (node->key == key) 
   //       return node;
      
   //    if (node->key < key) 
   //       node->right = insert(node->right, key);
      
   //    else 
   //       node->left = insert(node->left, key);
      
   //    return node;
   // }
   Node<T>* insertNode(Node<T>* node, T value) {
      if (node == nullptr) {
            return new Node<T>(value);
      }
      if(node->data > value){
         node->left = insertNode(node->left, value);
      }
      else if (value > node->data) {
         node->right = insertNode(node->right, value);
      }
      else {
         cout<<value<<": ";
         throw Errors("Duplicates are not allowed!! Error!!");
      }
      return node;
   }

   // T find_min(void){
   //    Node<T> * node  = root;

   //    if(node == NULL){
   //       __throw_out_of_range("root is NULLLL");
   //    }
   //    if(node->left == NULL && node->right == NULL){
   //       return node->data;
   //    }
   //    Node <T> * curr = root;
   //    while (curr->left != NULL)
   //    {
   //       curr = curr->left;
   //    }
   //    return curr->data;
      
   // }
   // T find_max(void){
   //    Node<T> * node  = root;

   //    if(node == NULL){
   //       __throw_out_of_range("root is NULLLL");
   //    }
   //    if(node->left == NULL && node->right == NULL){
   //       return node->data;
   //    }
   //    Node <T> * curr = root;
   //    while (curr->right != NULL)
   //    {
   //       curr = curr->right;
   //    }
   //    return curr->data;
   // }
   Node<T>* findMin(Node<T>* node) {
      
      try{
         if(node == NULL){
            throw Errors("root is NULLLL");
         }

         while (node && node->left != nullptr) {
            node = node->left;
         }
         return node;
      }
      catch (const Errors & e) {
         cout<< e.showError() << endl;
      }

    }

   Node<T>* findMax(Node<T>* node) {
      try{
         if(node == NULL){
            __throw_out_of_range("root is NULLLL");
         }
         while (node && node->right != nullptr) {
            node = node->right;
         }
         return node;
      }
      catch (const Errors & e) {
         cout<< e.showError() << endl;
      }
   }

   void inorderTraversal(Node<T>* node) {
      if(node==nullptr) return;
      if (node != nullptr) {
         inorderTraversal(node->left);
         cout << node->data << " ";
         inorderTraversal(node->right);
      }
    }

   void preorderTraversal(Node<T>* node) {
      if(node==nullptr) return;
      if (node != nullptr) {
         cout << node->data << " ";
         preorderTraversal(node->left);
         preorderTraversal(node->right);
      }
   }

   void postorderTraversal(Node<T>* node) {
      if(node==nullptr) return;
      if (node != nullptr) {
         postorderTraversal(node->left);
         postorderTraversal(node->right);
         cout << node->data << " ";
      }
   }

public:

   BST () {
      root = NULL;
   }
   void insert(T a){
      try
      {
         root = insertNode(root , a); 
      }
      catch( const Errors & e)
      {
         cout<< e.showError() << endl;
      }
      
   }
   void inorder (void) {
      inorderTraversal(root);
   }
   void preorder (void) {
      preorderTraversal(root);
   }
   void postorder (void) {
      postorderTraversal(root);
   }

};


int main(){

   //////////THE OUTPUT FILE IS VERY BIG. WORKS FINE IN THE PC's TERMINAL!

   ifstream inFile("int-sort.txt");
   if(!inFile.is_open()){
      cout<<" Errrorr"<<endl;
   }
   else{
      string a;
            // cout<<endl;
      BST<int> tree;
      int count = 0;
      while (inFile >> a)
      {
         if(a == "inorder"){
            cout<<endl;
            cout<<"INORDER: ";
            tree.inorder();
            cout<<endl;
            cout<<endl;
         }
         else if(a == "preorder"){
            cout<<endl;
            cout<<"PREORDER: ";
            tree.preorder();
            cout<<endl;
            cout<<endl;
         }
         else if(a == "postorder"){
            cout<<endl;
            cout<<"POSTORDER: ";
            tree.postorder();
            cout<<endl;
            cout<<endl;
         }
         else if(a == "insert")
         {
            int num;
            inFile >> num;
            // cout<< a << num << endl; 
            // count++;
               tree.insert(num);
         }
         else if(a == "delete"){
            int num;
            inFile >> num;
            continue;
         }
         else {
            int num;
            inFile >> num;
            try
            {
               throw Errors("Invalid INPUT");
            }
            catch( const Errors & e )
            {
               cout<<a <<endl;
               cout<<e.showError() << endl;
            } 
            
         }
      }
      // tree.inorder();
      // cout<<endl;
      // tree.preorder();
      // cout<<count<<endl;
      inFile.close();
   }
   ifstream inFile2("char-sort.txt");
   if(!inFile2.is_open()){
      cout<<" Errrorr"<<endl;
   }
   else{
      string a;
            // cout<<endl;
      BST<char> tree;
      char count = 0;
      while (inFile2 >> a)
      {
         if(a == "inorder"){
            cout<<endl;
            cout<<"INORDER: ";
            tree.inorder();
            cout<<endl;
            cout<<endl;
         }
         else if(a == "preorder"){
            cout<<endl;
            cout<<"PREORDER: ";
            tree.preorder();
            cout<<endl;
            cout<<endl;
         }
         else if(a == "postorder"){
            cout<<endl;
            cout<<"POSTORDER: ";
            tree.postorder();
            cout<<endl;
            cout<<endl;
         }
         else if(a == "insert")
         {
            char num;
            inFile2 >> num;
            // cout<< a << num << endl; 
            // count++;
               tree.insert(num);
         }
         else if(a == "delete"){
            char num;
            inFile2 >> num;
            continue;
         }
         else {
            char num;
            inFile2 >> num;
            try
            {
               throw Errors("Invalid INPUT");
            }
            catch( const Errors & e )
            {
               cout<<a <<endl;
               cout<<e.showError() << endl;
            } 
            
         }
      }
      // tree.inorder();
      // cout<<endl;
      // tree.preorder();
      // cout<<count<<endl;
      inFile2.close();
   }
   ifstream inFile3("float-sort.txt");
   if(!inFile3.is_open()){
      cout<<" Errrorr"<<endl;
   }
   else{
      string a;
            // cout<<endl;
      BST<float> tree;
      float count = 0;
      while (inFile3 >> a)
      {
         if(a == "inorder"){
            cout<<endl;
            cout<<"INORDER: ";
            tree.inorder();
            cout<<endl;
            cout<<endl;
         }
         else if(a == "preorder"){
            cout<<endl;
            cout<<"PREORDER: ";
            tree.preorder();
            cout<<endl;
            cout<<endl;
         }
         else if(a == "postorder"){
            cout<<endl;
            cout<<"POSTORDER: ";
            tree.postorder();
            cout<<endl;
            cout<<endl;
         }
         else if(a == "insert")
         {
            float num;
            inFile3 >> num;
            // cout<< a << num << endl; 
            // count++;
               tree.insert(num);
         }
         else if(a == "delete"){
            float num;
            inFile3 >> num;
            continue;
         }
         else {
            float num;
            inFile3 >> num;
            try
            {
               throw Errors("Invalid INPUT");
            }
            catch( const Errors & e )
            {
               cout<<a <<endl;
               cout<<e.showError() << endl;
            } 
            
         }
      }
      // tree.inorder();
      // cout<<endl;
      // tree.preorder();
      // cout<<count<<endl;
      inFile3.close();
   }
   ifstream inFile4("string-sort.txt");
   if(!inFile4.is_open()){
      cout<<" Errrorr"<<endl;
   }
   else{
      string a;
            // cout<<endl;
      BST<string> tree;
      while (inFile4 >> a)
      {
         if(a == "inorder"){
            cout<<endl;
            cout<<"INORDER: ";
            tree.inorder();
            cout<<endl;
            cout<<endl;
         }
         else if(a == "preorder"){
            cout<<endl;
            cout<<"PREORDER: ";
            tree.preorder();
            cout<<endl;
            cout<<endl;
         }
         else if(a == "postorder"){
            cout<<endl;
            cout<<"POSTORDER: ";
            tree.postorder();
            cout<<endl;
            cout<<endl;
         }
         else if(a == "insert")
         {
            string num;
            inFile4 >> num;
            // cout<< a << num << endl; 
            // count++;
               tree.insert(num);
         }
         else if(a == "delete"){
            string num;
            inFile4 >> num;
            continue;
         }
         else {
            string num;
            inFile4 >> num;
            try
            {
               throw Errors("Invalid INPUT");
            }
            catch( const Errors & e )
            {
               cout<<a <<" " << num << ":  ";
               cout<<e.showError() << endl;
            } 
            
         }
      }
      // tree.inorder();
      // cout<<endl;
      // tree.preorder();
      // cout<<count<<endl;
      inFile4.close();
   }
   


   return 0;
}