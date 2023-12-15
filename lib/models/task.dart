// Kelas Task menampilkan sebuah tugas dalam aplikasi
class Task {
  int? id; // ID tugas
  String? title; // Judul tugas
  String? note; // Catatan tugas
  int? isCompleted; // Status penyelesaian tugas
  String? date; // Tanggal tugas
  String? startTime; // Waktu mulai tugas
  String? endTime; // Waktu selesai tugas
  int? color; // Warna tugas
  int? remind; // Pengingat tugas
  String? repeat; // Pengulangan tugas

  // Konstruktor untuk membuat objek Task
  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
  });

  // Konstruktor untuk membuat objek Task dari Map JSON
  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    color = json['color'];
    remind = json['remind'];
    repeat = json['repeat'];
  }

  // Mengonversi objek Task menjadi Map JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['note'] = this.note;
    data['isCompleted'] = this.isCompleted;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['color'] = this.color;
    data['remind'] = this.remind;
    data['repeat'] = this.repeat;
    return data;
  }
}
