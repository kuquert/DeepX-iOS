//
//  Repo.swift
//  DeepX
//
//  Created by Marcus Vinicius Kuquert on 27/05/17.
//  Copyright © 2017 Marcus Vinicius Kuquert. All rights reserved.
//

import Foundation
import ObjectMapper

extension Date {
    var raw: Any {
        return ISO8601DateTransform()
    }
}

class Repo: Mappable {
    
    var id: Int?
    var name: String?
    var full_name: String?
    var owner: String?
    //add "private"
    var isPrivate: String?
    var html_url: String?
    var description: String?
    var fork: String?
    var url: String?
    var forks_url: String?
    var keys_url: String?
    var collaborators_url: String?
    var teams_url: String?
    var hooks_url: String?
    var issue_events_url: String?
    var events_url: String?
    var assignees_url: String?
    var branches_url: String?
    var tags_url: String?
    var blobs_url: String?
    var git_tags_url: String?
    var git_refs_url: String?
    var trees_url: String?
    var statuses_url: String?
    var languages_url: String?
    var stargazers_url: String?
    var contributors_url: String?
    var subscribers_url: String?
    var subscription_url: String?
    var commits_url: String?
    var git_commits_url: String?
    var comments_url: String?
    var issue_comment_url: String?
    var contents_url: String?
    var compare_url: String?
    var merges_url: String?
    var archive_url: String?
    var downloads_url: String?
    var issues_url: String?
    var pulls_url: String?
    var milestones_url: String?
    var notifications_url: String?
    var labels_url: String?
    var releases_url: String?
    var deployments_url: String?
    var created_at: Date?
    var updated_at: Date?
    var pushed_at: Date?
    var git_url: String?
    var ssh_url: String?
    var clone_url: String?
    var svn_url: String?
    var homepage: String?
    var size: Int?
    var stargazers_count: Int?
    var watchers_count: Int?
    var language: String?
    var has_issues: Bool?
    var has_projects: Bool?
    var has_downloads: Bool?
    var has_wiki: Bool?
    var has_pages: Bool?
    var forks_count: Int?
    var mirror_url: String?
    var open_issues_count: Int?
    var forks: Int?
    var open_issues: Int?
    var watchers: Int?
    var default_branch: String?
    var permissions: Permissions?
    
    
    required init(map: Map) {
        //Required empty implementation
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
        self.full_name <- map["full_name"]
        self.owner <- map["owner"]
        self.isPrivate <- map["private"]
        self.html_url <- map["html_url"]
        self.description <- map["description"]
        self.fork <- map["fork"]
        self.url <- map["url"]
        self.forks_url <- map["forks_url"]
        self.keys_url <- map["keys_url"]
        self.collaborators_url <- map["collaborators_url"]
        self.teams_url <- map["teams_url"]
        self.hooks_url <- map["hooks_url"]
        self.issue_events_url <- map["issue_events_url"]
        self.events_url <- map["events_url"]
        self.assignees_url <- map["assignees_url"]
        self.branches_url <- map["branches_url"]
        self.tags_url <- map["tags_url"]
        self.blobs_url <- map["blobs_url"]
        self.git_tags_url <- map["git_tags_url"]
        self.git_refs_url <- map["git_refs_url"]
        self.trees_url <- map["trees_url"]
        self.statuses_url <- map["statuses_url"]
        self.languages_url <- map["languages_url"]
        self.stargazers_url <- map["stargazers_url"]
        self.contributors_url <- map["contributors_url"]
        self.subscribers_url <- map["subscribers_url"]
        self.subscription_url <- map["subscription_url"]
        self.commits_url <- map["commits_url"]
        self.git_commits_url <- map["git_commits_url"]
        self.comments_url <- map["comments_url"]
        self.issue_comment_url <- map["issue_comment_url"]
        self.contents_url <- map["contents_url"]
        self.compare_url <- map["compare_url"]
        self.merges_url <- map["merges_url"]
        self.archive_url <- map["archive_url"]
        self.downloads_url <- map["downloads_url"]
        self.issues_url <- map["issues_url"]
        self.pulls_url <- map["pulls_url"]
        self.milestones_url <- map["milestones_url"]
        self.notifications_url <- map["notifications_url"]
        self.labels_url <- map["labels_url"]
        self.releases_url <- map["releases_url"]
        self.deployments_url <- map["deployments_url"]
        self.created_at <- (map["created_at"], ISO8601DateTransform())
        self.updated_at <- (map["updated_at"], ISO8601DateTransform())
        self.pushed_at <- (map["pushed_at"], ISO8601DateTransform())
        self.git_url <- map["git_url"]
        self.ssh_url <- map["ssh_url"]
        self.clone_url <- map["clone_url"]
        self.svn_url <- map["svn_url"]
        self.homepage <- map["homepage"]
        self.size <- map["size"]
        self.stargazers_count <- map["stargazers_count"]
        self.watchers_count <- map["watchers_count"]
        self.language <- map["language"]
        self.has_issues <- map["has_issues"]
        self.has_projects <- map["has_projects"]
        self.has_downloads <- map["has_downloads"]
        self.has_wiki <- map["has_wiki"]
        self.has_pages <- map["has_pages"]
        self.forks_count <- map["forks_count"]
        self.mirror_url <- map["mirror_url"]
        self.open_issues_count <- map["open_issues_count"]
        self.forks <- map["forks"]
        self.open_issues <- map["open_issues"]
        self.watchers <- map["watchers"]
        self.default_branch <- map["default_branch"]
        self.permissions <- map["permissions"]
    }
}
