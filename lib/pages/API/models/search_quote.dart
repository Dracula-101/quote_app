class SearchQuote {
  int? count;
  int? totalCount;
  int? page;
  int? totalPages;
  int? lastItemIndex;
  List<Results>? results;

  SearchQuote(
      {this.count,
      this.totalCount,
      this.page,
      this.totalPages,
      this.lastItemIndex,
      this.results});

  SearchQuote.fromJson(Map<String, dynamic> json) {
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

  static SearchQuote dataFromSnapshot(Map<String, dynamic> data) {
    return SearchQuote.fromJson(data);
  }
}

class Results {
  String? sId;
  List<String>? tags;
  String? content;
  String? author;
  String? authorId;
  String? authorSlug;
  int? length;
  String? dateAdded;
  String? dateModified;
  int? iV;

  Results(
      {this.sId,
      this.tags,
      this.content,
      this.author,
      this.authorId,
      this.authorSlug,
      this.length,
      this.dateAdded,
      this.dateModified,
      this.iV});

  Results.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tags = json['tags'].cast<String>();
    content = json['content'];
    author = json['author'];
    authorId = json['authorId'];
    authorSlug = json['authorSlug'];
    length = json['length'];
    dateAdded = json['dateAdded'];
    dateModified = json['dateModified'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['tags'] = tags;
    data['content'] = content;
    data['author'] = author;
    data['authorId'] = authorId;
    data['authorSlug'] = authorSlug;
    data['length'] = length;
    data['dateAdded'] = dateAdded;
    data['dateModified'] = dateModified;
    data['__v'] = iV;
    return data;
  }
}
