class RandomQuote {
  int? count;
  int? totalCount;
  int? page;
  int? totalPages;
  int? lastItemIndex;
  List<Results>? results;

  RandomQuote(
      {this.count,
      this.totalCount,
      this.page,
      this.totalPages,
      this.lastItemIndex,
      this.results});

  RandomQuote.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalCount = json['totalCount'];
    page = json['page'];
    totalPages = json['totalPages'];
    lastItemIndex = json['lastItemIndex'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['totalCount'] = totalCount;
    data['page'] = page;
    data['totalPages'] = totalPages;
    data['lastItemIndex'] = lastItemIndex;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static RandomQuote dataFromSnapshot(Map<String, dynamic> data) {
    return RandomQuote.fromJson(data);
  }
}

class Results {
  List<String>? tags;
  String? sId;
  String? author;
  String? content;
  String? authorSlug;
  int? length;
  String? dateAdded;
  String? dateModified;

  Results(
      {this.tags,
      this.sId,
      this.author,
      this.content,
      this.authorSlug,
      this.length,
      this.dateAdded,
      this.dateModified});

  Results.fromJson(Map<String, dynamic> json) {
    tags = json['tags'].cast<String>();
    sId = json['_id'];
    author = json['author'];
    content = json['content'];
    authorSlug = json['authorSlug'];
    length = json['length'];
    dateAdded = json['dateAdded'];
    dateModified = json['dateModified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tags'] = tags;
    data['_id'] = sId;
    data['author'] = author;
    data['content'] = content;
    data['authorSlug'] = authorSlug;
    data['length'] = length;
    data['dateAdded'] = dateAdded;
    data['dateModified'] = dateModified;
    return data;
  }
}
