class CloudStorageException implements Exception {
  const CloudStorageException();
}

// C
class CouldNotCreateListException extends CloudStorageException {}

// R
class CouldNotGetAllListException extends CloudStorageException {}

// U
class CouldNotUpdateListException extends CloudStorageException {}

// D
class CouldNotDeleteListException extends CloudStorageException {}
