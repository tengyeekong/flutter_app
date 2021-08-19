class ListItem {
  String id;
  String name;
  String distance;

  ListItem({required this.id, required this.name, required this.distance});

  factory ListItem.fromJson(Map<String, dynamic> json) {
    return ListItem(
        id: json['id'], name: json['list_name'], distance: json['distance']);
  }
}
