extension NSFetchedResultsController {
    
    func update(predicate predicate: NSPredicate?) {
        NSFetchedResultsController.deleteCacheWithName(cacheName)
        fetchRequest.predicate = predicate
        fetchData()
    }
    
    func empty() -> Bool {
        return count() == 0
    }
    
    func count() -> Int {
        var fetchError:NSError?
        let count = managedObjectContext.countForFetchRequest(fetchRequest, error: &fetchError)
        return count
    }
    
    func fetchData() -> Bool {
        do {
            try performFetch()
        } catch {
            return false
        }
        return true
    }
    
    func numberOfSections() -> Int {
        guard let sections = sections
            else { return 0 }
        return sections.count
    }
    
    func numberOfRows(section section: Int) -> Int {
        guard section < numberOfSections()
            else { return 0 }
        guard let sectionInfo = sections?[section]
            else { return 0 }
        return sectionInfo.numberOfObjects
    }
    
    func itemExists(indexPath indexPath: NSIndexPath) -> Bool {
        guard indexPath.section < numberOfSections()
            else { return false }
        guard indexPath.row < numberOfRows(section: indexPath.section)
            else { return false }
        return true
    }
    
    func object(indexPath indexPath: NSIndexPath) -> AnyObject? {
        guard itemExists(indexPath: indexPath)
            else { return nil }
        return objectAtIndexPath(indexPath)
    }
    
    func object(row row: Int) -> AnyObject? {
        let indexPath = NSIndexPath(forRow: row, inSection: 0)
        guard itemExists(indexPath: indexPath)
            else { return nil }
        return objectAtIndexPath(indexPath)
    }
    
}
