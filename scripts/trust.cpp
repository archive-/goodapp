/*
 * TEAM NULL (c) 2012
 * compile: g++ trust.cpp -o trust
 *
 * use: ./trust < [FILE]
 *  or: ./trust < [File] > [OUTFILE]
 *
 * input file format example:
 * 4
 * 2.0 3.0 12.1 40.9
 * 1 2
 * 2 3
 * 1 4
 * 4 2
 *
 * first number is number of members.
 * second line shows base trust
 * then recommender_id recommendee_id
 *
 * DID NOT USE RELAXATION/GAUSS-SEIDEL.
 *
 * uses recursive propogation of trust through tree, halting
 * propogation after a given tolerance is reached
 *
 * set trust_fraction_given to a desired fraction of rating to
 * give to others when you trust them. IF TRUST FRACTION >= 1
 * ALGORITHM WILL NOT HALT! but this would mean you can give
 * members more trust than you have...doesn't make sense
 *
 * trust given to others depends on your trust, which depends
 * (among other things) on the trust of members that trust you
 */


#include <iostream>
using namespace std;

double tolerance = 0.001; // if no user input desired could make static
double trust_fraction_given = .2; // if no user input desired could make static

struct trust_list_node
{
  trust_list_node *next_trusted_member;
  int member_trusted;//index of array
};

struct member
{
  double base_trust;
  double total_trust;
  trust_list_node *next_trusted_member;
  int num_trusted_by_user;
  int id;
};

void test_structure(member** mem, int length)
{
  for (int i = 0; i < length; i++) {
    cout << "member " << i+1 << " has trust " << mem[i]->total_trust << " and trusts members: ";
    trust_list_node* node = mem[i]->next_trusted_member;
    while (node != NULL) {
      cout << node->member_trusted+1 << " and ";
      node = node->next_trusted_member;
    }
    cout << "(nobody)" << endl;
  }
}

void print_structure(member** mem, int length)
{
  for (int i = 0; i < length; i++) {
    cout << mem[i]->total_trust;
    if (i < length - 1)
      cout << " ";
  }
}

void propagate_trust(member** members, int member_number, double trust_given)
{
  if (trust_given < tolerance) {
    if (trust_given >= tolerance * 0.5) {
      members[member_number]->total_trust = members[member_number]->total_trust + tolerance;
    }
    return;
  }

  members[member_number]->total_trust = members[member_number]->total_trust + trust_given;

  trust_list_node* node = members[member_number]->next_trusted_member;
  while (node != NULL)
  {
    propogate_trust(members,
                    node->member_trusted,
                    trust_given * trust_fraction_given / members[member_number]->num_trusted_by_user);
    node = node->next_trusted_member;
  }
}

void create_network(member** members, int length)
{
  for(int i = 0; i < length; i++) {
    trust_list_node *node = members[i]->next_trusted_member;
    while(node != NULL) {
      propagate_trust(members, node->member_trusted,
              members[i]->base_trust * trust_fraction_given / members[i]->num_trusted_by_user);
      node = node->next_trusted_member;
    }
  }
}

int find_member(int member_id, member* members, int num_members)
{
  for(int i = 0; i < num_members; i++)
    if(members[i].id == member_id)
      return i;

  cout<<"Err: no member "<<member_id<<endl;
  exit(-1);
  return -1;
}

int main()
{
  char colon;
  int num_members, ival;
  char garbage;
  double dval;
  cin >> num_members;
  member *members[num_members];
  for (int i = 0; i < num_members; i++) {
    member *new_member = new member;
    new_member->next_trusted_member = NULL;
    new_member->total_trust = new_member->base_trust = dval;
    new_member->id = ival;
    new_member->num_trusted_by_user = 0;
    members[i] = new_member;
  }

  int member_id = -1;
  int old_id = -1;
  int trusted_id = -1;
  int old_trusted = -1;

  int member_index;
  int trusted_index;
  string line;
  while(getline(cin, line))
  {
    cin >> member_id;
    cin >> trusted_id;

    if(member_id == -1 || trusted_id == -1)
      break;

    if(old_id == member_id && old_trusted == trusted_id)
      break;

    old_id = member_id;
    old_trusted = trusted_id;

    member_index = find_member(member_id, *members, num_members);
    trusted_index = find_member(trusted_id, *members, num_members);

    trust_list_node *new_node = new trust_list_node;
    new_node->member_trusted = trusted_index;
    new_node->next_trusted_member = members[member_index]->next_trusted_member;
    members[member_index]->next_trusted_member = new_node;
    members[member_index]->num_trusted_by_user++;
  }
  create_network((members), num_members);
  //test_structure((members), num_members);
  print_structure((members), num_members);
  return 0;
}
